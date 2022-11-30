
import UIKit

class BalanceCell: UITableViewCell {
    
    @IBOutlet weak var accountCurrencyLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    func configureCell(currency: String, balance: String) {
        accountCurrencyLabel.text = currency
        balanceLabel.text = balance
    }
    
}
