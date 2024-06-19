import UIKit
import WebKit

class ESGDataViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var ESGWebView: WKWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        ESGWebView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ESGWebView.navigationDelegate = self
        loadWebPage("https://finance.yahoo.com/")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = true
    }
}
