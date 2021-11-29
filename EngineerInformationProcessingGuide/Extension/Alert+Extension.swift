import UIKit

extension UIViewController {
    // @escaping: 탈출 클로저
    func showAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true) {
            // action
        }
    }
    
    func showOneButtonAlert(title: String, message: String, cancelTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel)
        
        alert.addAction(cancel)
        
        self.present(alert, animated: true) {
            // action
        }
    }
}
