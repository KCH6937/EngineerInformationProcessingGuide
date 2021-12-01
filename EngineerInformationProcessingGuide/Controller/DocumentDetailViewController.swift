import UIKit
import Kingfisher
import RealmSwift
import Network

class DocumentDetailViewController: UIViewController {
    
    static let identifier = "DocumentDetailViewController"
    
    let localRealm = try! Realm()
    
    var category: String = ""
    var sort: String = ""
    
    var bookData: [Book] = []
    var blogData: [Blog] = []
    var cafeData: [Cafe] = []

    @IBOutlet weak var typeOfTestSegmentedControl: UISegmentedControl!
    @IBOutlet weak var docDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "Bar")
        self.docDetailTableView.backgroundColor = UIColor(named: "Background")
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        docDetailTableView.delegate = self
        docDetailTableView.dataSource = self
        
        let docDetailNib = UINib(nibName: DocumentDetailTableViewCell.identifier, bundle: nil)
        docDetailTableView.register(docDetailNib, forCellReuseIdentifier: DocumentDetailTableViewCell.identifier)
        
        fetchData(type: "필기") // at first view
    }
    
    @IBAction func typeOfTestChange(_ sender: UISegmentedControl) {
        let type: [String] = ["필기", "실기"]
        fetchData(type: type[typeOfTestSegmentedControl.selectedSegmentIndex])
    }
    
}

// MARK: - UDF func
extension DocumentDetailViewController {
    
    func fetchData(type: String) {
        categoryToSerivceId()

        SearchAPIManager.shared.fetchLocationData(serviceid: category, query: "정보처리기사 \(type)", display: "30", start: "1", sort: sort) { code, json in
            
            switch code {
            case 200:
                for item in json["items"].arrayValue {

                    var title = item["title"].stringValue
                    title = self.removeBoldTag(text: title)
                    
                    var description = item["description"].stringValue
                    description = self.removeBoldTag(text: description)
                    
                    let link = item["link"].stringValue
                    
                    switch self.category {
                    case "book":
                        let author = "\(self.removeBoldTag(text: item["author"].stringValue)) / \(self.removeBoldTag(text: item["publisher"].stringValue))"
                        let price = item["discount"].stringValue == "" ? item["price"].stringValue : item["discount"].stringValue
                        let pubdate = item["pubdate"].stringValue
                        let image = item["image"].stringValue
                        let data = Book(title: title, price: price, author: author, pubdate: pubdate, description: description, image: image, link: link)
                        
                        self.bookData.append(data)
                    case "cafearticle":
                        let author = item["cafename"].stringValue
                        let data = Cafe(title: title, cafeName: author, description: description, link: link)
                        
                        if author != "중고나라" {
                            self.cafeData.append(data)
                        }
                    case "blog":
                        let author = item["bloggername"].stringValue
                        let postDate = item["postdate"].stringValue
                        let data = Blog(title: title, bloggerName: author, description: description, postDate: postDate, link: link)
                        
                        self.blogData.append(data)
                    default:
                        print("alert 아직 준비중")
                    }
                }
                self.docDetailTableView.reloadData()
                
            case 400:
                print("400 입니다")
            default:
                print("error")
            }
        }
    }
    
    func categoryToSerivceId() {
        switch category {
        case "교재", "book":
            sort = "sim"
            category = "book"
            bookData.removeAll()
        case "블로그", "blog":
            sort = "sim"
            category = "blog"
            blogData.removeAll()
        case "카페", "cafearticle":
            sort = "sim"
            category = "cafearticle"
            cafeData.removeAll()
        default:
            sort = "sim"
            category = "book"
        }
        
    }
    
    func removeBoldTag(text: String) -> String {
        return text.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    }
    
    func countData() -> Int {
        switch category {
        case "book":
            return bookData.count
        case "blog":
            return blogData.count
        case "cafearticle":
            return cafeData.count
        default:
            return 0
        }
    }
    
    func saveData(indexPath: IndexPath) {
        var saveRecord: Record
        
        switch category {
        case "book":
            let row = bookData[indexPath.row]
            saveRecord = Record(title: row.title, writter: row.author, descript: row.description, link: row.link, category: category, pubdate: row.pubdate, image: row.image, price: row.price)
        case "blog":
            let row = blogData[indexPath.row]
            saveRecord = Record(title: row.title, writter: row.bloggerName, descript: row.description, link: row.link, category: category, pubdate: row.postDate, image: "", price: "")
        case "cafearticle":
            let row = cafeData[indexPath.row]
            saveRecord = Record(title: row.title, writter: row.cafeName, descript: row.description, link: row.link, category: category, pubdate: "", image: "", price: "")
        default:
            saveRecord = Record(title: "NONE DATA", writter: "", descript: "", link: "", category: "", pubdate: "", image: "", price: "")
        }
        
        try! localRealm.write {
            localRealm.add(saveRecord)
        }
        
    }
    
    func retCategoryDataLink(indexPath: IndexPath) -> String {
        
        switch category {
        case "book":
            return bookData[indexPath.row].link
        case "blog":
            return blogData[indexPath.row].link
        case "cafearticle":
            return cafeData[indexPath.row].link
        default:
            return "NONE DATA"
        }
    }

}

// MARK: - Table View Config
extension DocumentDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("countData()")
        print(countData())
        return countData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = docDetailTableView.dequeueReusableCell(withIdentifier: DocumentDetailTableViewCell.identifier, for: indexPath) as?
                DocumentDetailTableViewCell else { return UITableViewCell() }
        
        if category == "book" {
            let row = bookData[indexPath.row]
        
            if let url = URL(string: row.image) {
                cell.posterImageView.kf.setImage(with: url)
            } else {
                cell.posterImageView.image = UIImage(systemName: "xmark")
            }
            
            cell.titleLabel.text = row.title
            cell.priceFormLabel.text = "가격: "
            cell.priceLabel.text = row.price
            cell.authorFormLabel.text = "저자: "
//            cell.wonLabel.text = "원"
            cell.authorLabel.text = row.author
            cell.dateFormLabel.text = "출간일: "
            cell.dateLabel.text = row.pubdate
            cell.descriptionLabel.text = row.description
            
        } else if category == "blog" {
            let row = blogData[indexPath.row]
            
            cell.posterImageView.isHidden = true
            
            cell.titleLabel.text = row.title
            cell.priceFormLabel.text = "작성자:"
            cell.priceLabel.text = row.bloggerName
            cell.authorFormLabel.text = ""
            cell.authorLabel.text = ""
            cell.wonLabel.text = ""
            cell.dateFormLabel.text = row.postDate
            cell.dateLabel.text = ""
            cell.descriptionLabel.text = row.description
            
        } else if category == "cafearticle" {
            let row = cafeData[indexPath.row]
            
            cell.posterImageView.isHidden = true
            
            cell.titleLabel.text = row.title
            cell.priceFormLabel.text = "카페:"
            cell.priceLabel.text = row.cafeName
            cell.authorFormLabel.text = ""
            cell.authorLabel.text = ""
            cell.wonLabel.text = ""
            cell.dateFormLabel.text = ""
            cell.dateLabel.text = ""
            cell.descriptionLabel.text = row.description
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = retCategoryDataLink(indexPath: indexPath)
        
        guard let webViewController = self.storyboard?.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController else { return }
        
        webViewController.link = link
        
        self.navigationController?.pushViewController(webViewController, animated: true)
        
        showAlert(title: "알림", message: "방문기록에 저장해도 될까요?", okTitle: "저장") {
            self.saveData(indexPath: indexPath)
        }
    }
    
}
