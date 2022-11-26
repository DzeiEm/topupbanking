
import Foundation
import UIKit

class TransferMoneyViewControlller: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var screenLabel: UILabel!
    @IBOutlet weak var receiverNumberTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var subjectTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - Variables
    let header = "Transfer Money"
    
    //MARK: - Actions
    @IBAction func backButtonTapped() {
        let homeScreen = HomeViewController()
        homeScreen.modalPresentationStyle = .fullScreen
        present(homeScreen, animated: true)
    }
    
    @IBAction func sendButtonTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        screenLabel.text = header
    }

}
