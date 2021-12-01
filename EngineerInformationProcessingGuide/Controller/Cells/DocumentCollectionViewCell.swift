import UIKit

class DocumentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DocumentCollectionViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func config() {
        self.layer.cornerRadius = CGFloat(15)
        self.layer.borderColor = CGColor(red: 0.180, green: 0.420, blue: 0.459, alpha: CGFloat(1))
        self.layer.borderWidth = CGFloat(2)
 
        titleLabel.textColor = .black
    }
    
}
