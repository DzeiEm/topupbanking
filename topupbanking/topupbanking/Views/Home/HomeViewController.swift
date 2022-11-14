
import UIKit

class HomeViewController: UIViewController {

    enum ButtonTitle: String {
        case transfer = "Transfer money"
        case history = "Transaction History"
    }
    
    // MARK: - OUTLETS
    @IBOutlet weak var historyButtonLabel: UIButton!
    @IBOutlet weak var transferMoneyButtonLabel: UIButton!
    
    // MARK: - AUTLETS
    @IBAction func transactionHistoryButtonTapped() {
     
        print("Transactions button tapped")
    }
    
    @IBAction func transferMoneyButtonTapped() {
        
        print("Transfer money tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyButtonLabel.titleLabel?.text = ButtonTitle.history.rawValue
        transferMoneyButtonLabel.titleLabel?.text = ButtonTitle.transfer.rawValue
    }
}
