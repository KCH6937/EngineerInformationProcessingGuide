import UIKit

extension UIViewController {
    func fontApply() {
        // nav Bar
        let nsAtr: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "BM DoHyeon OTF", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "Button")!
        ]
        
        self.navigationController?.navigationBar.titleTextAttributes = nsAtr
        
        // tab bar
        self.tabBarController?.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "BM DoHyeon OTF", size: 10)!], for: .normal)
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "BM DoHyeon OTF", size: 10)!]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
    }
    
}
