
import Foundation
import UIKit

class TransactionHistoryViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var screenLabel: UILabel!
    
    //MARK: - Variables
    let header = "Transaction History"
    
    // MARK: - Actions

    @IBAction func backButtonTapped() {
        proceedToHomeScreen()
    }
    
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        setupTableView()
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
        let cellNib = UINib(nibName: "TransactionHistoryCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "TransactionHistoryCell")
    }

    func fetchAllTransactions() {
        //TODO: fetch data
    }
}



extension TransactionHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryCell", for: indexPath)
        
        guard let transactionHistoryCell = cell as? TransactionHistoryCell else {
            return cell
        }
        transactionHistoryCell.configureCell(name: "Julija", amount: "20")
        return transactionHistoryCell
        
    }
}

extension TransactionHistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func proceedToTransactionsDetailsScreen() {
        let transactionDetailsScreen = TransactionDetailsViewController()
        transactionDetailsScreen.modalPresentationStyle = .fullScreen
        present(transactionDetailsScreen, animated: true)
    }
    
    func proceedToHomeScreen() {
        let homeScreen = HomeViewController()
        homeScreen.modalPresentationStyle = .fullScreen
        present(homeScreen, animated: true)
    }
}
