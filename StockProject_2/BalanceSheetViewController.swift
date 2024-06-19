import UIKit

struct SummaryDetailItem {
    let title: String
    let value: String
}

class BalanceSheetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var balanceSheetLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
 
    var symbol: String?
    var summaryDetailItems: [SummaryDetailItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SummaryDetailCell")
        fetchSummaryDetailData()
        
        configureBalanceSheetLabel()
        configureTableView()
    }
    
    func configureBalanceSheetLabel() {
        balanceSheetLabel.text = "Balance-Sheet"
        balanceSheetLabel.font = UIFont.boldSystemFont(ofSize: 24)
        balanceSheetLabel.textColor = UIColor(hex: "#333333")
        balanceSheetLabel.backgroundColor = UIColor.clear
        balanceSheetLabel.textAlignment = .center
            
        balanceSheetLabel.layer.shadowColor = UIColor.gray.cgColor
        balanceSheetLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        balanceSheetLabel.layer.shadowOpacity = 0.7
        balanceSheetLabel.layer.shadowRadius = 4.0
        balanceSheetLabel.layer.masksToBounds = false
    }
    
    func configureTableView() {
        tableView.backgroundColor = UIColor(hex: "#E0F7FA")
        tableView.separatorColor = UIColor.lightGray
    }
    
    func fetchSummaryDetailData() {
        guard let symbol = symbol else { return }
        
        let apiKey = "5705e467e4mshd00e8a63abddaf3p16b10fjsn6a5227986dfd"
        let urlString = "https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-summary?symbol=\(symbol)&region=US"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("apidojo-yahoo-finance-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let summaryDetail = json["summaryDetail"] as? [String: Any] {
                    
                    var items: [SummaryDetailItem] = []
                    for (key, value) in summaryDetail {
                        if let valueDict = value as? [String: Any],
                           let rawValue = valueDict["raw"] {
                            items.append(SummaryDetailItem(title: key, value: "\(rawValue)"))
                        } else if let valueString = value as? String {
                            items.append(SummaryDetailItem(title: key, value: valueString))
                        } else {
                            print("Failed to parse \(key)")
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.summaryDetailItems = items
                        self.tableView.reloadData()
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error parsing JSON: \(error)")
                    self.summaryDetailItems = [SummaryDetailItem(title: "Error", value: "Failed to parse JSON data")]
                    self.tableView.reloadData()
                }
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summaryDetailItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SummaryDetailCell")
        let item = summaryDetailItems[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.value
        
        cell.backgroundColor = UIColor(hex: "#E3F2FD")
        cell.textLabel?.textColor = UIColor(hex: "#0D47A1")
        cell.detailTextLabel?.textColor = UIColor(hex: "#1976D2")
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell
    }

}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
