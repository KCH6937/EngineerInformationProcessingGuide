import UIKit

class DocumentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DocumentCollectionViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func config() {
        self.layer.cornerRadius = CGFloat(15)
 
        titleLabel.textColor = .black
    }
    
}
