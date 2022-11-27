
import Foundation

struct UserManager {
    
//    let keychain: KeychainHelper
//    private let userDefaults = UserDefaults.standard
    
    static var users = [User]()
    static var accounts: [Account] = ()
    
    static var accountBalance = 0.00
    
    static var curencyAccount: String?
    static var loggedInAccount: User? {
        willSet(newUser) {
            print("About to set username", newUser?.phone ?? "nil" )
        }
        didSet {
            print("About to set username", loggedInAccount?.phone ?? "nil" )
        }
    }
    
    func getUserId() -> Int? {
        guard let userId = KeychainHelper.keychain.get(KeychainHelper.Key.Credentials.userIdentifier.rawValue) else {
            return nil
        }
        return Int(userId)
    }
    
    func setUserId(_ userId: Int) {
        KeychainHelper.keychain.set(String(userId), forKey: KeychainHelper.Key.Credentials.userIdentifier.rawValue)
    }
    
    func setAccount(user: User,
                           currency: String?,
                           balance: String?) throws -> Account? {
                
       // return Account(phone: <#T##String#>, currency: <#T##String#>, balance: <#T##String#>)
    }
    
    func login(phone: String?, password: String?) throws {
        
        let user = try LoginViewModel.checkIsTextfieldsAreNotEmpty(phoneNo: phone, password: password)
        try LoginViewModel.checkIsPasswordMatchesWithCredentials(phoneNo: phone, password: password)
        UserManager.loggedInAccount = user
    }
    
    func register(phone: String?,
                  password: String?,
                  confirmPassword: String?,
                  currency: String?,
                  accountCurrency: String?,
                  balance: String?) throws {
        
       
        let newUser = try? RegisterViewModel.checkIstextfieldsAreNotEmpty(phoneNo: phone,
                                                                      password: password,
                                                                      confirmPassword: confirmPassword)
        
        if RegisterViewModel.isPhoneNumberIsTaken(newUser?.phone) {
            throw Errors.Registration.userAlreadyExist
        }
        
        try RegisterViewModel.isPasswordSecure(newUser?.password)
        try RegisterViewModel.isPassworsMatch(newUser?.password, newUser?.confirmPassword)
        
        UserDefaultsHelper.saveUser(newUser)
        UserManager.loggedInAccount = newUser
        UserManager.users.append(newUser)
        
        
        //var accountCurrency = try? RegisterViewModel.setAccountCurrency(account: accountCurrency)
//
//        var account = try? setAccount(user: "", currency: accountCurrency, balance: balance)
//
//        AccountManager.accounts.append(account)

    }
}
