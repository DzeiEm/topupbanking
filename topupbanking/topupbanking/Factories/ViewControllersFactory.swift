
import Foundation
import UIKit

protocol ViewControlllersFactory {
    
    func makeRegistrationViewController() -> RegistrationViewController
    func makeHomeViewController() -> HomeViewController
    func makeTransactionViewController() -> TransactionViewController
}

extension DependencyContainer: ViewControlllersFactory {
    
    func makeRegistrationViewController() -> RegistrationViewController {
        return RegistrationViewController()
    }
    
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController()
    }
    
    func makeTransactionViewController() -> TransactionViewController {
        return TransactionViewController()
    }
}

