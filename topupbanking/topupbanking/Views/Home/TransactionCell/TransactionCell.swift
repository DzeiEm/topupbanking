
import Foundation
import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var transactionSubjectLabel: UILabel!
    @IBOutlet weak var receiverLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func configure(receiver: String, amount: String, subject: String) {
        transactionSubjectLabel.text = subject
        receiverLabel.text = receiver
        amountLabel.text = amount
    }
}
