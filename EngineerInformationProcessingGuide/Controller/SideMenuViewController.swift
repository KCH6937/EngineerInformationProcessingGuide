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
        showAlert(title: "알림", message: "모든 방문기록을 지우시겠어요?", okTitle: "확인") {
            RecordViewController.isAllDelete = true
        }
    }
}
