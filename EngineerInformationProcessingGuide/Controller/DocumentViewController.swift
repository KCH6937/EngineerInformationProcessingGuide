import UIKit

class DocumentViewController: UIViewController {

    @IBOutlet weak var docCollectionView: UICollectionView!
    
    let docInfo = DocumentInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        cell.posterImageView.image = UIImage(systemName: doc.image)
        
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
        
    }

}
