
import Foundation
import UIKit

class TransactionHistoryCell: UITableViewCell {

    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func configureCell(name: String, amount: String) {
        receiverNameLabel.text = name
        amountLabel.text = amount
    }
}
