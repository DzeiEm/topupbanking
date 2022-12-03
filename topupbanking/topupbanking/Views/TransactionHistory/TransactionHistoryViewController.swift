
import Foundation
import UIKit

class TransactionHistoryViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var screenLabel: UILabel!
    
    //MARK: - Variables

    var parsedTransactions = [Transaction]()
    let apiManager = APIManager()
    
    let header = "Transaction History"
    
    enum CellName: String {
        case transactionHistory = "TransactionHistoryCell"
    }
    
    // MARK: - Actions

    @IBAction func backButtonTapped() {
        proceedToHomeScreen()
    }
    
    //MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        setupTableView()
        fetchAllTransactions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        screenLabel.text = header
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 65
    }
    
    func configureCell() {
        let cellNib = UINib(nibName: CellName.transactionHistory.rawValue, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellName.transactionHistory.rawValue)
    }

    func fetchAllTransactions() {
        apiManager.getAllUserTransactions(completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let transactions):
                print(transactions)
                self?.setTransactions(transactions)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        })
    }
    
    func setTransactions(_ transactions: [Transaction]) {
        parsedTransactions = transactions
    }
}


extension TransactionHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        parsedTransactions.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellName.transactionHistory.rawValue, for: indexPath)
        
        guard let transactionHistoryCell = cell as? TransactionHistoryCell else {
            return cell
        }
        
        transactionHistoryCell.configureCell(name: parsedTransactions[indexPath.row].receiverNo,
                                             amount: String(parsedTransactions[indexPath.row].amount)
        )
        return transactionHistoryCell
    }
}


extension TransactionHistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let transactionDetailsViewController = TransactionDetailsViewController()
        let transactionList = parsedTransactions[indexPath.section]
        transactionDetailsViewController.sender = transactionList.senderNo
        transactionDetailsViewController.amount = String(transactionList.amount)
        transactionDetailsViewController.receiver = transactionList.receiverNo
        transactionDetailsViewController.subject = transactionList.subject
        
        transactionDetailsViewController.modalPresentationStyle = .fullScreen
        present(transactionDetailsViewController, animated: true)
    }
    
    func proceedToHomeScreen() {
        
        let homeScreen = HomeViewController()
        homeScreen.modalPresentationStyle = .fullScreen
        present(homeScreen, animated: true)
    }
}
