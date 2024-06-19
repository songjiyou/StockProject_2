import UIKit

class ExchangeRateViewController: UIViewController {

    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var dollarTextField: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    let apiKey = "7226d1d51cad3d2dc6d53b30"
    let exchangeRateURL = "https://v6.exchangerate-api.com/v6/7226d1d51cad3d2dc6d53b30/latest/USD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "#E0F7FA")
                
        dollarTextField.delegate = self
        
        configureExchangRateLabel()
        configureButtons()
    }
    
    func configureExchangRateLabel() {
        exchangeRateLabel.text = "Exchange Rate"
        exchangeRateLabel.font = UIFont.boldSystemFont(ofSize: 24)
        exchangeRateLabel.textColor = UIColor(hex: "#333333")
        exchangeRateLabel.backgroundColor = UIColor.clear
        exchangeRateLabel.textAlignment = .center
            
        exchangeRateLabel.layer.shadowColor = UIColor.gray.cgColor
        exchangeRateLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        exchangeRateLabel.layer.shadowOpacity = 0.7
        exchangeRateLabel.layer.shadowRadius = 4.0
        exchangeRateLabel.layer.masksToBounds = false
    }
    
    func configureButtons() {
        let button = convertButton
        button?.layer.cornerRadius = 10
        button?.backgroundColor = UIColor(hex: "#4F79A3")
        button?.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        convertCurrency()
    }
    
    func convertCurrency() {
        guard let dollarAmount = dollarTextField.text, !dollarAmount.isEmpty else {
            resultLabel.text = "Please enter a valid amount"
            return
        }
        
        fetchExchangeRate { (rate) in
            if let rate = rate {
                let dollarValue = Double(dollarAmount) ?? 0.0
                let convertedValue = dollarValue * rate
                DispatchQueue.main.async {
                    self.resultLabel.text = String(format: "%.2f KRW", convertedValue)
                }
            } else {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Failed to fetch exchange rate"
                }
            }
        }
    }
    
    func fetchExchangeRate(completion: @escaping (Double?) -> Void) {
        guard let url = URL(string: exchangeRateURL) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print("Error fetching exchange rate: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let conversionRates = json["conversion_rates"] as? [String: Any],
                   let krwRate = conversionRates["KRW"] as? Double {
                    completion(krwRate)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        task.resume()
    }
}

extension ExchangeRateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        convertCurrency()
        return true
    }
}
