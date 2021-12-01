import UIKit
import SideMenu

class CustomSideMenuNavigation: SideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.backgroundColor = UIColor(named: "Bar")
        self.presentationStyle = .menuSlideIn
        self.menuWidth = self.view.frame.width * 0.5
        
        let nsAtr: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "BM DoHyeon OTF", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "Button")!
        ]
        
        self.navigationBar.titleTextAttributes  = nsAtr
    }
}
