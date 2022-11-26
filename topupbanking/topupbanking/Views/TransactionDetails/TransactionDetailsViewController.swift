
import UIKit
import Foundation

class TransactionDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    //MARK: - Valriables
    var balance = 0.0
    
    //MARK: - Actions
    @IBAction func backButtonTapped() {
        navigateToTransactionHistory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountLabel.text = String(balance)
    }
    
}



extension TransactionDetailsViewController {
    
    func navigateToTransactionHistory() {
        let transactionHistory = TransactionHistoryViewController()
        transactionHistory.modalPresentationStyle = .fullScreen
        present(transactionHistory, animated: true)
    }
}
