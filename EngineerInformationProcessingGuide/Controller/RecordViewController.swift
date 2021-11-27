import UIKit
import RealmSwift
import Network
import SwiftUI

class RecordViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    var records: Results<Record>!

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
    
    func eachCategoryRecords() -> [Int] {
        var eachCategoryRecordsCount: [Int] = [0, 0, 0]
        
        for i in records {
            if i.category == "book" {
                eachCategoryRecordsCount[0] += 1
            } else if i.category == "blog" {
                eachCategoryRecordsCount[1] += 1
            } else if i.category == "cafearticle" {
                eachCategoryRecordsCount[2] += 1
            }
        }
        
        return eachCategoryRecordsCount
    }
    
}


// MARK: - Table View Config
extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfCategories()
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
            return eachCategoryRecords()[0]
        } else if section == 1 {
            return eachCategoryRecords()[1]
        } else {
            return eachCategoryRecords()[2]
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = recordTableView.dequeueReusableCell(withIdentifier: DocumentDetailTableViewCell.identifier, for: indexPath) as? DocumentDetailTableViewCell else {
            return UITableViewCell() }
        
        var row = records[indexPath.row]
        
        var sectionArea: Int = 0

        if indexPath.section == 0 {
            if let url = URL(string: row.image!) {
                cell.posterImageView.kf.setImage(with: url)
            } else {
                cell.posterImageView.image = UIImage(systemName: "xmark")
            }
            cell.titleLabel.text = row.title
            cell.priceLabel.text = row.price
            cell.authorLabel.text = row.writter
            cell.dateLabel.text = row.pubdate
            cell.descriptionLabel.text = row.descript
            
        } else if indexPath.section == 1 {
            sectionArea += eachCategoryRecords()[0]
            row = records[indexPath.row + sectionArea]
            
            cell.posterImageView.isHidden = true
            cell.titleLabel.text = row.title
            cell.priceFormLabel.text = "작성자:"
            cell.priceLabel.text = row.writter
            cell.authorFormLabel.text = ""
            cell.authorLabel.text = ""
            cell.wonLabel.text = ""
            cell.dateFormLabel.text = row.pubdate
            cell.dateLabel.text = ""
            cell.descriptionLabel.text = row.descript
            
        } else {
            sectionArea += eachCategoryRecords()[1]
            row = records[indexPath.row + sectionArea]
            
            cell.posterImageView.isHidden = true
            cell.titleLabel.text = row.title
            cell.priceFormLabel.text = "카페:"
            cell.priceLabel.text = row.writter
            cell.authorFormLabel.text = ""
            cell.authorLabel.text = ""
            cell.wonLabel.text = ""
            cell.dateFormLabel.text = ""
            cell.dateLabel.text = ""
            cell.descriptionLabel.text = row.descript
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
        try! localRealm.write {
            localRealm.delete( records[indexPath.row] )
            tableView.reloadData()
        }
    }

    
   
}
