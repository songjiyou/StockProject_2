import UIKit
import WebKit

class StockVideoViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button4.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button5.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        loadInitialPage()
    }
    
    func loadInitialPage() {
    let initialUrl = "https://www.youtube.com/"
        if let url = URL(string: initialUrl) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton){
        let videoUrls = [
        "https://www.youtube.com/watch?v=S2CZCDf3Euo",
        "https://www.youtube.com/watch?v=60Ivcuj1rGA",
        "https://youtu.be/LiXlbekRIoc?si=XXNxlgpaDmkzLP6A",
        "https://www.youtube.com/watch?v=c6n_QJIvICY",
        "https://www.youtube.com/watch?v=yeYVrqm7FpM",
        "https://www.youtube.com/"
        ]
        
        var urlString: String?
        
        switch sender {
        case button1:
            urlString = videoUrls[0]
        case button2:
            urlString = videoUrls[1]
        case button3:
            urlString = videoUrls[2]
        case button4:
            urlString = videoUrls[3]
        case button5:
            urlString = videoUrls[4]
        default:
            break
        }
        
        if let urlString = urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
