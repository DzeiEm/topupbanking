
import UIKit

class HomeViewController: UIViewController {

    enum ScreenTitles: String {
        case transferButtonLabel = "Transfer money"
        case historyButtonLabel = "History"
        case recentTransactionTableViewHeader = "Recent transactions"
    }
    
    enum CellName: String {
        case transaction = "TransactionCell"
        case balance = "BalanceCell"
    }
    
    // MARK: - OUTLETS
    
    @IBOutlet private weak var balanceTableView: UITableView!
    @IBOutlet private weak var historyButtonLabel: UIButton!
    @IBOutlet private weak var transferMoneyButtonLabel: UIButton!
    @IBOutlet private weak var transactionTableHeader: UILabel!
    @IBOutlet private weak var recentTransactionsTableview: UITableView!
    

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
        configureBalanceCell()
        configureRecentTransactionCell()
        setupBalanceTableView()
        setupRecentTransactionTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        transactionTableHeader.text = ScreenTitles.recentTransactionTableViewHeader.rawValue
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
 
    //MARK: - Balance table view cell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MAX 3
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = balanceTableView.dequeueReusableCell(withIdentifier: CellName.balance.rawValue, for: indexPath)
        
        guard let balanceCell = cell as? BalanceCell else {
            return cell
        }
        
        balanceCell.configureCell(currency: UserManager.curencyAccount,
                                  balance: String(UserManager.accountBalance))
        return balanceCell
    }
    

    
    func setupBalanceTableView() {
        balanceTableView.delegate = self
        balanceTableView.dataSource = self
        balanceTableView.rowHeight = 40
    }
    
    func setupRecentTransactionTableView() {
        balanceTableView.delegate = self
        balanceTableView.dataSource = self
        balanceTableView.rowHeight = 40
    }
    
    func configureBalanceCell() {
        let balanceCell = UINib(nibName: CellName.balance.rawValue, bundle: nil)
        balanceTableView.register(balanceCell, forCellReuseIdentifier: CellName.balance.rawValue)
    }
    
    func configureRecentTransactionCell() {
        let recentTransactionCell = UINib(nibName: CellName.transaction.rawValue, bundle: nil)
        recentTransactionsTableview.register(recentTransactionCell, forCellReuseIdentifier: CellName.transaction.rawValue)
    }
}


extension HomeViewController {
    
    func proceedToTransactionHistoryScreen() {
        let historyScreen = TransactionHistoryViewController()
        historyScreen.modalPresentationStyle = .fullScreen
        present(historyScreen, animated: true, completion: nil)
    }
    
    func proceedToTransferMoneyScreen() {
        let transferMoneyScreen = TransferMoneyViewControlller(nibName: "TransferMoneyView", bundle: nil)
        transferMoneyScreen.modalPresentationStyle = .fullScreen
        present(transferMoneyScreen, animated: true, completion: nil)
    }
    
    func logOut() {
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .fullScreen
        present(loginScreen, animated: true, completion: nil)
    }
}
