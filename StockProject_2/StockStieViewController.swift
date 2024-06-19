import UIKit
import WebKit

class StockSiteViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var btnInvesting: UIButton!
    @IBOutlet weak var btnSeekingAlpha: UIButton!
    @IBOutlet weak var btnFINVIZ: UIButton!
    @IBOutlet weak var btnTradingView: UIButton!
    
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.navigationDelegate = self
        loadWebPage("https://www.google.com/")
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
    
    func checkUrl(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("https://")
        if !flag {
            strUrl = "https://" + strUrl
        }
        return strUrl
    }
    
    @IBAction func btnGotoUrl(_ sender: UIButton) {
        let myUrl = checkUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    
    
    @IBAction func btnInvesting(_ sender: UIButton) {
        loadWebPage("https://kr.investing.com/")
    }
    
    @IBAction func btnSeekingAlpha(_ sender: UIButton) {
        loadWebPage("https://seekingalpha.com/")
    }
    
    @IBAction func btnFINVIZ(_ sender: UIButton) {
        loadWebPage("https://finviz.com/")
    }
    
    @IBAction func btnTradingView(_ sender: UIButton) {
        loadWebPage("https://www.tradingview.com/")
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading()
    }
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload()
    }
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack()
    }
    
    @IBAction func btnGOForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()
    }
    
}
