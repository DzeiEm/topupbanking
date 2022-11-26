
import UIKit

class HomeViewController: UIViewController {

    enum ScreenTitles: String {
        case transferButtonLabel = "Transfer money"
        case historyButtonLabel = "History"
        case recentTransactionTableViewHeader = "Recent transactions"
    }
    
    // MARK: - OUTLETS
    @IBOutlet weak var historyButtonLabel: UIButton!
    @IBOutlet weak var transferMoneyButtonLabel: UIButton!
    @IBOutlet weak var transactionTableHeader: UILabel!
    
    // MARK: - AUTLETS
    @IBAction func transactionHistoryButtonTapped() {
      proceedToTransactionHistoryScreen()
    }
    
    @IBAction func transferMoneyButtonTapped() {
        proceedToTransferMoneyScreen()
    }
    
    @IBAction func logoutBUttonTapped() {
        logOut()
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        historyButtonLabel.titleLabel?.text = ScreenTitles.historyButtonLabel.rawValue
        transferMoneyButtonLabel.titleLabel?.text = ScreenTitles.transferButtonLabel.rawValue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        transactionTableHeader.text = ScreenTitles.recentTransactionTableViewHeader.rawValue
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
    
    func logOut() {
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .fullScreen
        present(loginScreen, animated: true, completion: nil)
    }
}
