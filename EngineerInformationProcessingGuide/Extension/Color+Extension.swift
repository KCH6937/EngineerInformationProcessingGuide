import UIKit

extension AppDelegate {
    static let BACKGROUND = UIColor(named: "Background")

    func colorApply() {
        let BACKGROUND = UIColor(named: "Background")
        let BAR = UIColor(named: "Bar")
        let BUTTON = UIColor(named: "Button")
        
        UINavigationBar.appearance().barTintColor = BACKGROUND
        UINavigationBar.appearance().backgroundColor = BAR
        UINavigationBar.appearance().tintColor = BAR
        
        UITabBar.appearance().barTintColor = BAR
        UITabBar.appearance().backgroundColor = BAR
        UITabBar.appearance().tintColor = BACKGROUND
        UITabBar.appearance().unselectedItemTintColor = BUTTON
        
        UIBarButtonItem.appearance().tintColor = BUTTON
    }
}
