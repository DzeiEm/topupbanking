
import UIKit

class Navigator: UIViewController {
    
    func dismissCompletion() {
        dismiss(animated: true, completion: nil)
    }
    
    func proceedToHomeScreen() {
        let homeScreen = HomeViewController()
        homeScreen.modalPresentationStyle = .fullScreen
        present(homeScreen, animated: true)
    }
    
    func proceedToLoginScreen() {
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .fullScreen
        present(loginScreen, animated: true)
    }
    
    func proceedToTransactionScreen() {
        let transactionScreen = TransactionViewController()
        transactionScreen.modalPresentationStyle = .fullScreen
        present(transactionScreen, animated: true)
    }
}

