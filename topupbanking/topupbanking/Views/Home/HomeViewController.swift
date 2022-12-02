
import UIKit

class HomeViewController: UIViewController {

    enum ScreenTitles: String {
        case transferButtonLabel = "Transfer money"
        case historyButtonLabel = "History"
        case recentTransactionTableViewHeader = "Recent transactions"
    }
    
    enum CellName: String {
        case transaction = "TransactionCell"
    }
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var accountCurrencylabel: UILabel!
    @IBOutlet private weak var historyButtonLabel: UIButton!
    @IBOutlet private weak var transferMoneyButtonLabel: UIButton!
    @IBOutlet private weak var transactionTableHeader: UILabel!
    @IBOutlet private weak var recentTransactionsTableview: UITableView!
    var userManager: UserManager!
    let apiManager = APIManager()
    var parsedTransactions = [Transaction]()

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
        setupUILabels()
        configureRecentTransactionCell()
        setupRecentTransactionTableView()
        fetchRecentTransactions()
        accountCurrencylabel.text = String(UserManager.accountBalance)
        amountLabel.text = String(UserManager.accountBalance)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        transactionTableHeader.text = ScreenTitles.recentTransactionTableViewHeader.rawValue
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func fetchRecentTransactions() {
        apiManager.getAllUserTransactions(completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let transactions):
                print(transactions)
                self?.setTransactions(transactions)
                DispatchQueue.main.async {
                    self?.recentTransactionsTableview.reloadData()
                }
            }
        })
    }
    
    func setTransactions(_ transactions: [Transaction]) {
        parsedTransactions = transactions
    }
 
    //MARK: - Balance table view cell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return parsedTransactions.prefix(5).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = recentTransactionsTableview.dequeueReusableCell(withIdentifier:  CellName.transaction.rawValue, for: indexPath)

        guard let recentTransactionCell = cell as? TransactionCell else {
            return cell
        }
        
        recentTransactionCell.configure(receiver: parsedTransactions[indexPath.row].receiverNo,
                                        amount: String(parsedTransactions[indexPath.row].amount),
                                        subject: parsedTransactions[indexPath.row].subject)
        return recentTransactionCell
    }
    
    func setupRecentTransactionTableView() {
        recentTransactionsTableview.delegate = self
        recentTransactionsTableview.dataSource = self
        recentTransactionsTableview.rowHeight = 60
    }
    
    func setupUILabels() {
        historyButtonLabel.titleLabel?.text = ScreenTitles.historyButtonLabel.rawValue
        transferMoneyButtonLabel.titleLabel?.text = ScreenTitles.transferButtonLabel.rawValue
    }
    
    func setAccountBalance()  {
      //TODO: Add user balance
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
