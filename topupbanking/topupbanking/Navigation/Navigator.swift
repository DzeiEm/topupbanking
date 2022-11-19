
import UIKit

class Navigator: UIViewController {
    
    func dismissCompletion() {
        dismiss(animated: true, completion: nil)
    }
    
    func proceedToHomeScreen() {
        let homeScreen = HomeViewController()
        modalPresentationStyle = .fullScreen
        present(homeScreen, animated: true)
    }
    
    func proceedToLoginScreen() {
        let loginScreen = LoginViewController()
        modalPresentationStyle = .fullScreen
        present(loginScreen, animated: true)
    }
    
    func proceedToTransactionScreen() {
        let transactionScreen = TransactionViewController()
        modalPresentationStyle = .fullScreen
        present(transactionScreen, animated: true)
    }
}

