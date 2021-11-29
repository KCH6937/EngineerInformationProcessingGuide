import UIKit

class DocumentDetailTableViewCell: UITableViewCell {
    
    static let identifier = "DocumentDetailTableViewCell"

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceFormLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var wonLabel: UILabel!
    @IBOutlet weak var authorFormLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateFormLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        priceFormLabel.text = "가격: "
        priceLabel.text = nil
        authorFormLabel.text = "저자: "
        authorLabel.text = nil
        wonLabel.text = "원"
        dateFormLabel.text = nil
        dateLabel.text = nil
        descriptionLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
