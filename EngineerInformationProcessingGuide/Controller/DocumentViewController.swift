import UIKit

class DocumentViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var docCollectionView: UICollectionView!
    
    let docInfo = DocumentInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "Bar")
        self.docCollectionView.backgroundColor = UIColor(named: "Background")
        
        if defaults.bool(forKey: "First Launch") == false {
            
            showOneButtonAlert(title: "알림", message: "안녕하세요!\n정처기 가이드는\n정보처리기사를 효율적으로 취득하도록\n여러 정보를 쉽고 간략하게 알려드립니다.", cancelTitle: "확인")
            
            defaults.set(true, forKey: "First Launch")
        }
        
        docCollectionView.delegate = self
        docCollectionView.dataSource = self
        
        config()
    }

}

// MARK: - Collection View
extension DocumentViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docInfo.document.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocumentCollectionViewCell.identifier, for: indexPath) as?
                DocumentCollectionViewCell else { return UICollectionViewCell() }

        cell.config()
        
        let doc = docInfo.document[indexPath.item]
        
        cell.titleLabel.text = doc.title
        cell.posterImageView.image = UIImage(named: doc.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let docDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: DocumentDetailViewController.identifier) as? DocumentDetailViewController else { return }
        
        docDetailViewController.category = docInfo.document[indexPath.item].title
        
        self.navigationController?.pushViewController(docDetailViewController, animated: true)
    }
    
}

// MARK: - Config
extension DocumentViewController {
    
    func config() {
        
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 20
        let width = UIScreen.main.bounds.width / 2 - 30
        
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        docCollectionView.collectionViewLayout = layout
        
        fontApply()
    }

}
