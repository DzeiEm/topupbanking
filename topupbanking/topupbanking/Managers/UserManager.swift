
import Foundation

struct UserManager {
        
    static var users = [UserRequest]()
    let apiManager: APIManager
    var onSuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?
    
    static var accountBalance = 0.00
    static var curencyAccount: String = ""

    static var loggedInAccount: UserRequest? {
        willSet(newUser) {
            print("About to set username", newUser?.phoneNumber ?? "nil" )
        }
        didSet {
            print("About to set username", loggedInAccount?.phoneNumber ?? "nil" )
        }
    }
    
    func login(phone: String?, password: String?) throws {
        
        let user = try LoginViewModel.checkIsTextfieldsAreNotEmpty(phoneNo: phone, password: password)
        
        try LoginViewModel.checkIsPasswordMatchesWithCredentials(phoneNo: phone, password: password)
        //UserManager.loggedInAccount = user
    }
    
    func register(phone: String?,
                  password: String?,
                  confirmPassword: String?,
                  accountCurrency: String?,
                  balance: String?) throws {
        
    
        var confirmPasswordValue = confirmPassword
        let user = try RegisterViewModel.checkIstextfieldsAreNotEmpty(phoneNo: phone,
                                                                      password: password,
                                                                      confirmPassword: confirmPassword)
        
        if RegisterViewModel.isPhoneNumberIsTaken(user.phoneNumber) {
            throw Errors.Registration.userAlreadyExist
        }
        
        let acc = RegisterViewModel.setAccountCurrency(account: accountCurrency)
        try RegisterViewModel.isPasswordSecure(user.password)
        try RegisterViewModel.isPassworsMatch(user.password, confirmPasswordValue)
                
        apiManager.registerUser(user) { result in
            switch result {
            case .success:
                self.onSuccess?()
            case .failure(let error):
                self.onFailure?(error.description)
            }
        }
        
        let registerUser = UserRequest(phoneNumber: user.phoneNumber, password: user.password)
        let account = AccountRequest(phoneNumber: registerUser.phoneNumber, currency: acc, balance: UserManager.accountBalance)
        
        apiManager.createAccount(account) { result in
            switch result {
            case .success:
                self.onSuccess?()
            case .failure(let error):
                self.onFailure?(error.description)
            }
        }
        
        UserDefaultsHelper.saveUser(user)
        UserManager.loggedInAccount = user
        AccountManager.accounts.append(account)
        print("ACCOUNT: \(account)")
        UserManager.users.append(registerUser)
    }
}
