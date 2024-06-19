import UIKit

extension UIColor {
    convenience init(hex: String) {
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
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

struct StockPrice: Decodable {
    let symbol: String
    let price: Double
}

struct StockPriceResponse: Decodable {
    let price: Price
}

struct Price: Decodable {
    let regularMarketPrice: MarketPrice
}

struct MarketPrice: Decodable {
    let raw: Double
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var historicDataButton: UIButton!
    @IBOutlet weak var balanceSheetButton: UIButton!
    @IBOutlet weak var esgReportButton: UIButton!
    
    
    var searchQuery: String?
    var stockPrices: [StockPrice] = []
          
   override func viewDidLoad() {
        super.viewDidLoad()
        
    self.view.backgroundColor = UIColor(hex: "#E0F7FA")
    
    tableView.dataSource = self
    tableView.delegate = self
    searchBar.delegate = self
    
    balanceSheetButton.isHidden = true
    historicDataButton.isHidden = true
    esgReportButton.isHidden = true
    
    configureButtons()
   }
    
    func configureButtons() {
        let buttons = [historicDataButton, balanceSheetButton, esgReportButton]
        for button in buttons {
            button?.layer.cornerRadius = 10
            button?.backgroundColor = UIColor(hex: "#4F79A3")
            button?.setTitleColor(.white, for: .normal)
        }
    }
          
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        fetchStockPrice(for: query)
    }
          
    func fetchStockPrice(for symbol: String) {
        let apiKey = "5705e467e4mshd00e8a63abddaf3p16b10fjsn6a5227986dfd"
        let urlString = "https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-summary?symbol=\(symbol)&region=US"
              
        guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return
        }
              
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("apidojo-yahoo-finance-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
              
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                  print("Network error: \(String(describing: error))")
                  return
            }
                  
            do {
                let response = try JSONDecoder().decode(StockPriceResponse.self, from: data)
                      let stockPrice = StockPrice(symbol: symbol, price: response.price.regularMarketPrice.raw)
                DispatchQueue.main.async {
                    self.stockPrices = [stockPrice]
                    self.tableView.reloadData()
                    self.balanceSheetButton.isHidden = false
                    self.historicDataButton.isHidden = false
                    self.esgReportButton.isHidden = false
                      }
                  } catch {
                      DispatchQueue.main.async {
                          print("JSON parsing error: \(error.localizedDescription)")
                      }
                  }
              }
              
              task.resume()
          }
          
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return stockPrices.count
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
              let stockPrice = stockPrices[indexPath.row]
              cell.textLabel?.text = stockPrice.symbol
              cell.detailTextLabel?.text = "\(stockPrice.price) USD"
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            
              return cell
          }

    @IBAction func showBalanceSheet(_ sender: UIButton) {
        performSegue(withIdentifier: "showBalanceSheet", sender: self)
    }
    
    @IBAction func showHistoricData(_ sender: UIButton) {
        performSegue(withIdentifier: "showHistoricData", sender: self)
    }

    @IBAction func showESGReport(_ sender: UIButton) {
        performSegue(withIdentifier: "showESGReport", sender: self)
    }
    
    @IBAction func Reload(_ sender: UIBarButtonItem) {
        searchBar.text = ""
        stockPrices.removeAll()
        tableView.reloadData()
        
        balanceSheetButton.isHidden = true
        historicDataButton.isHidden = true
        esgReportButton.isHidden = true
    }
    
    @IBAction func showStockSite(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showStockSite", sender: self)
    }
    
    @IBAction func showStockVideo(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showStockVideo", sender: self)
    }
    
    @IBAction func showExchangeRate(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showExchangeRate", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showBalanceSheet" {
                if let destinationVC = segue.destination as? BalanceSheetViewController {
                    destinationVC.symbol = stockPrices.first?.symbol
                }
            } else if segue.identifier == "showHistoricData" {
                if let destinationVC = segue.destination as? HistoricDataViewController {
                    destinationVC.symbol = stockPrices.first?.symbol
                }
            } 
        } 
}

