
import Foundation
import UIKit
import Combine

final class RegisterUserViewModel {
    
    private var apiManager: APIManager
    
    var onSuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    
    func registerUser(id: String?, phone: String?, password: String?, accountCurrency: String?, balance: String?) {
        guard
              let id = id,
              let phone = phone,
              let password = password,
              let accountCurrency = accountCurrency,
              let balance = balance,
              !id.isEmpty,
              !phone.isEmpty,
              !password.isEmpty,
              !accountCurrency.isEmpty,
              !balance.isEmpty
        else {
            onFailure?("Fill in required fields")
            return
        }
        isLoading.send(true)
        
        let user = RegisterUserModel(id: id,
                                     phone: phone,
                                     password: password,
                                     accountCurrency: accountCurrency,
                                     balance: balance)
        
        apiManager.registerUser(user) { [weak self] result in
            self?.isLoading.send(false)
            
            switch result {
            case .success:
                self?.onSuccess?()
            case .failure(let error):
                self?.onFailure?(error.description)
            }
            
        }
        
    }
}
