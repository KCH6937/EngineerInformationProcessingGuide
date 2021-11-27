import UIKit

class DocumentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DocumentCollectionViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func config() {
        self.backgroundColor = getRandomColor()
        self.layer.cornerRadius = CGFloat(15)
        posterImageView.tintColor = .white
        titleLabel.textColor = .white
    }
    
    
    func getRandomColor() -> UIColor{
          
          let randomRed:CGFloat = CGFloat(drand48())
          
          let randomGreen:CGFloat = CGFloat(drand48())
          
          let randomBlue:CGFloat = CGFloat(drand48())
          
          return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
