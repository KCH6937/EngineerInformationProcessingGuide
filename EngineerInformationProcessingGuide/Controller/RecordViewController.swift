import UIKit
import RealmSwift
import Network
import SwiftUI

class RecordViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    var records: Results<Record>!
    var recordDictionary: [Int: Array<Record>]! = [:]
    
    let CATEGORY_BLOG = "blog"
    let CATEGORY_CAFE = "cafearticle"
    let CATEGORY_BOOK = "book"
    
    let BOOK_STRING_CATEGORY_TO_SECTION = 0
    let BLOG_STRING_CATEGORY_TO_SECTION = 1
    let CAFE_STRING_CATEGORY_TO_SECTION = 2
    
    @IBOutlet weak var recordTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recordTableView.delegate = self
        recordTableView.dataSource = self
        
        records = localRealm.objects(Record.self)
        
        let docDetailNib = UINib(nibName: DocumentDetailTableViewCell.identifier, bundle: nil)
        recordTableView.register(docDetailNib, forCellReuseIdentifier: DocumentDetailTableViewCell.identifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        recordDictionary = toDictionary(records: records)
        recordTableView.reloadData()
    }
    
}

// MARK: - UDF func
extension RecordViewController {

    func numberOfCategories() -> Int {
        var recordCateogories: [String] = []
        
        for i in records {
            recordCateogories.append(i.category)
        }
        
        let set = Set(recordCateogories)
        return set.count
    }
    
    func toDictionary(records: Results<Record>) -> [Int: Array<Record>] {
        var dictionary: [Int: Array<Record>] = [:]
        dictionary[BOOK_STRING_CATEGORY_TO_SECTION] = Array<Record>()
        dictionary[BLOG_STRING_CATEGORY_TO_SECTION] = Array<Record>()
        dictionary[CAFE_STRING_CATEGORY_TO_SECTION] = Array<Record>()
        
        for element in records {
            if element.category == CATEGORY_BLOG {
                dictionary[BLOG_STRING_CATEGORY_TO_SECTION]?.append(element)
            }
            else if element.category == CATEGORY_BOOK {
                dictionary[BOOK_STRING_CATEGORY_TO_SECTION]?.append(element)
            }
            else {
                dictionary[CAFE_STRING_CATEGORY_TO_SECTION]?.append(element)
            }
        }
        return dictionary
    }
    
}

// MARK: - Table View Config
extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return recordDictionary.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "BOOK"
        } else if section == 1 {
            return "BLOG"
        } else {
            return "CAFE"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return recordDictionary[0]!.count
        } else if section == 1 {
            return recordDictionary[1]!.count
        } else {
            return recordDictionary[2]!.count
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = recordTableView.dequeueReusableCell(withIdentifier: DocumentDetailTableViewCell.identifier, for: indexPath) as? DocumentDetailTableViewCell else {
            return UITableViewCell() }
        
        let recordData = recordDictionary[indexPath.section]?[indexPath.row]
        
        if indexPath.section == 0 {
            if let url = URL(string: recordData!.image!) {
                cell.posterImageView.isHidden = false
                cell.posterImageView.kf.setImage(with: url)
            } else {
                cell.posterImageView.image = UIImage(systemName: "xmark")
            }
            cell.titleLabel.text = recordData!.title
            cell.priceLabel.text = recordData!.price
            cell.authorLabel.text = recordData!.writter
            cell.dateLabel.text = recordData!.pubdate
            cell.descriptionLabel.text = recordData!.descript
            
        } else if indexPath.section == 1 {
            cell.posterImageView.isHidden = true
            cell.titleLabel.text = recordData!.title
            cell.priceFormLabel.text = "작성자:"
            cell.priceLabel.text = recordData!.writter
            cell.authorFormLabel.text = ""
            cell.authorLabel.text = ""
            cell.wonLabel.text = ""
            cell.dateFormLabel.text = recordData!.pubdate
            cell.dateLabel.text = ""
            cell.descriptionLabel.text = recordData!.descript
            
        } else if indexPath.section == 2 {
            cell.posterImageView.isHidden = true
            cell.titleLabel.text = recordData!.title
            cell.priceFormLabel.text = "카페:"
            cell.priceLabel.text = recordData!.writter
            cell.authorFormLabel.text = ""
            cell.authorLabel.text = ""
            cell.wonLabel.text = ""
            cell.dateFormLabel.text = ""
            cell.dateLabel.text = ""
            cell.descriptionLabel.text = recordData!.descript
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        showAlert(title: "알림", message: "정말로 삭제하시겠습니까?", okTitle: "확인") {
            let data = self.recordDictionary[indexPath.section]![indexPath.row]
            self.recordDictionary[indexPath.section]!.remove(at: indexPath.row)
            
            try! self.localRealm.write {
                self.localRealm.delete(data)
                tableView.reloadData()
            }
        }
        
    }

    
   
}
