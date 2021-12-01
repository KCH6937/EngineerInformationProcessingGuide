import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "Bar")
        config()
    }
    
}

// MARK: - config
extension InfoViewController {

    func config() {
        fontApply()
    }
}
