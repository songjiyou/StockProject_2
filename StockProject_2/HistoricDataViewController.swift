import UIKit

struct HistoricDataItem {
    let date: String
    let close: Double
    let volume: Int
}

class HistoricDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var historicDataLabel: UILabel!
    
    var symbol: String?
    var historicDataItems: [HistoricDataItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoricDataCell")
        if let symbol = symbol {
            fetchHistoricData(for: symbol)
        }
        
        configureHistoricDataLabel()
        configureTableView()
    }
    
    func configureHistoricDataLabel() {
        historicDataLabel.text = "Historic-Data"
        historicDataLabel.font = UIFont.boldSystemFont(ofSize: 24)
        historicDataLabel.textColor = UIColor(hex: "#333333")
        historicDataLabel.backgroundColor = UIColor.clear
        historicDataLabel.textAlignment = .center
            
        historicDataLabel.layer.shadowColor = UIColor.gray.cgColor
        historicDataLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        historicDataLabel.layer.shadowOpacity = 0.7
        historicDataLabel.layer.shadowRadius = 4.0
        historicDataLabel.layer.masksToBounds = false
    }
    
    func configureTableView() {
        tableView.backgroundColor = UIColor(hex: "#E0F7FA")
        tableView.separatorColor = UIColor.lightGray
    }
    
    func fetchHistoricData(for symbol: String) {
        let apiKey = "5705e467e4mshd00e8a63abddaf3p16b10fjsn6a5227986dfd"
                let urlString = "https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-historical-data?symbol=\(symbol)&region=US"
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
                   let historicalData = json["prices"] as? [[String: Any]] {
                    
                    var items: [HistoricDataItem] = []
                    for dataPoint in historicalData {
                        if let date = dataPoint["date"] as? Int,
                           let close = dataPoint["close"] as? Double,
                           let volume = dataPoint["volume"] as? Int {
                            let dateString = Date(timeIntervalSince1970: TimeInterval(date)).description
                            items.append(HistoricDataItem(date: dateString, close: close, volume: volume))
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.historicDataItems = items
                        self.tableView.reloadData()
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error parsing JSON: \(error)")
                    self.historicDataItems = [HistoricDataItem(date: "Error", close: 0, volume: 0)]
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicDataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HistoricDataCell")
        let item = historicDataItems[indexPath.row]
        cell.textLabel?.text = item.date
        cell.detailTextLabel?.text = "Close: \(item.close), Volume: \(item.volume)"
        return cell
    }
}
