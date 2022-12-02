
import UIKit
import Foundation

class TransactionDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    var amount: String? = ""
    var sender: String? = ""
    var receiver: String? = ""
    var subject: String? = ""
    
    
    //MARK: - Valriables
    var balance = 0.0
    
    //MARK: - Actions
    @IBAction func backButtonTapped() {
        navigateToTransactionHistory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelValue()
    }
    
    func setLabelValue() {
        if let amount = amount {
            amountLabel.text = "Amount: \(amount)"
        }
        
        if let sender = sender {
            senderNameLabel.text = "Sender: \(sender)"
        }
        
        if let receiver = receiver {
            receiverNameLabel.text = "Receiver: \(receiver)"
        }
        if let subject = subject {
            subjectLabel.text = "Subject \(subject)"
        }
    }
    
}



extension TransactionDetailsViewController {
    
    func navigateToTransactionHistory() {
        let transactionHistory = TransactionHistoryViewController()
        transactionHistory.modalPresentationStyle = .fullScreen
        present(transactionHistory, animated: true)
    }
}
