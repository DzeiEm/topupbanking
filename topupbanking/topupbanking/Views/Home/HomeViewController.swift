
import UIKit

class HomeViewController: UIViewController {

    enum ButtonTitle: String {
        case transfer = "Transfer money"
        case history = "History"
    }
    
    // MARK: - OUTLETS
    @IBOutlet weak var historyButtonLabel: UIButton!
    @IBOutlet weak var transferMoneyButtonLabel: UIButton!
    
    // MARK: - AUTLETS
    @IBAction func transactionHistoryButtonTapped() {
      proceedToTransactionHistoryScreen()
    }
    
    @IBAction func transferMoneyButtonTapped() {
        proceedToTransferMoneyScreen()
    }
    
    
    @IBAction func logoutBUttonTapped() {
        
        print("LOGOU BUTTON TAPPED")
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .fullScreen
        present(loginScreen, animated: true, completion: nil)
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyButtonLabel.titleLabel?.text = ButtonTitle.history.rawValue
        transferMoneyButtonLabel.titleLabel?.text = ButtonTitle.transfer.rawValue
    }
}

extension HomeViewController {
    
    func proceedToTransactionHistoryScreen() {
        let historyScreen = TransactionHistoryViewController()
        historyScreen.modalPresentationStyle = .fullScreen
        present(historyScreen, animated: true, completion: nil)
    }
    
    func proceedToTransferMoneyScreen() {
        let transferMoneyScreen = TransferMoneyViewControlller()
        transferMoneyScreen.modalPresentationStyle = .fullScreen
        present(transferMoneyScreen, animated: true, completion: nil)
    }
}
