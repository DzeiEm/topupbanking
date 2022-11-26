
import Foundation
import UIKit

class TransactionHistoryCell: UITableViewCell {
    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var sentAmount: UILabel!
    
    func configureCell(name: String, amount: String) {
        receiverNameLabel.text = name
        sentAmount.text = amount
    }
}
