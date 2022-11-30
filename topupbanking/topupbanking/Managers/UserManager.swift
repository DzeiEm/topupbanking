
import Foundation

struct UserManager {
    
//    let keychain: KeychainHelper
//    private let userDefaults = UserDefaults.standard
    
    static var users = [User]()
    let apiManager: APIManager
    var onSuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?
    
    static var accountBalance = 0.00
    static var curencyAccount: String = ""

    
    static var loggedInAccount: User? {
        willSet(newUser) {
            print("About to set username", newUser?.phone ?? "nil" )
        }
        didSet {
            print("About to set username", loggedInAccount?.phone ?? "nil" )
        }
    }
    
//    func getUserId() -> Int? {
//        guard let userId = KeychainHelper.keychain.get(KeychainHelper.Key.Credentials.userIdentifier.rawValue) else {
//            return nil
//        }
//        return Int(userId)
//    }
//
//    func setUserId(_ userId: Int) {
//        KeychainHelper.keychain.set(String(userId), forKey: KeychainHelper.Key.Credentials.userIdentifier.rawValue)
//    }
    
    func login(phone: String?, password: String?) throws {
        
        let user = try LoginViewModel.checkIsTextfieldsAreNotEmpty(phoneNo: phone, password: password)
        
        try LoginViewModel.checkIsPasswordMatchesWithCredentials(phoneNo: phone, password: password)
//        UserManager.loggedInAccount = user
    }
    
    func register(phone: String?,
                  password: String?,
                  confirmPassword: String?,
                  accountCurrency: String?,
                  balance: String?) throws {
        
       
        let user = try RegisterViewModel.checkIstextfieldsAreNotEmpty(phoneNo: phone,
                                                                      password: password,
                                                                      confirmPassword: confirmPassword)
        
        if RegisterViewModel.isPhoneNumberIsTaken(user.phone) {
            throw Errors.Registration.userAlreadyExist
        }
        
        let acc = RegisterViewModel.setAccountCurrency(account: accountCurrency)
        try RegisterViewModel.isPasswordSecure(user.password)
        try RegisterViewModel.isPassworsMatch(user.password, user.confirmPassword)
        
//        UserRequest(phoneNumber: user.phone, password: user.password)
//        AccountRequest(phoneNumber: user.phone, currency: curencyAccount, balance: accountBalance)
        
        
        apiManager.registerUser(user) { result in
            switch result {
            case .success:
                self.onSuccess?()
            case .failure(let error):
                self.onFailure?(error.description)
            }
        }
        
        let registerUser = UserRequest(phoneNumber: user.phone, password: user.password)
     
        
        
        
//        UserDefaultsHelper.saveUser(user)
//        UserManager.loggedInAccount = user
//        UserManager.users.append(user)
        
        
        //var accountCurrency = try? RegisterViewModel.setAccountCurrency(account: accountCurrency)
//
//        var account = try? setAccount(user: "", currency: accountCurrency, balance: balance)
//
//        AccountManager.accounts.append(account)

    }
}
