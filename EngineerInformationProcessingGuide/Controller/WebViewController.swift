import UIKit
import WebKit

class WebViewController: UIViewController {
    
    static let identifier = "WebViewController"
    
    var link: String = ""

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "Bar")
        
        let url = URL(string: link)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
