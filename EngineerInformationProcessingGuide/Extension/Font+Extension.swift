import UIKit

extension UIViewController {
    func fontApply() {
        // nav
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "BM DoHyeon OTF", size: 20)!]
        
        // tab bar
        self.tabBarController?.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "BM DoHyeon OTF", size: 10)!], for: .normal)
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "BM DoHyeon OTF", size: 10)!]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
    }
    
}
