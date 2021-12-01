import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var dataDeleteButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Bar")
    }
    
    @IBAction func onclickDeleteAll(_ sender: UIButton) {
        
    }
}
