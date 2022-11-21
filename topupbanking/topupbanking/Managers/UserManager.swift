
import Foundation

struct UserManager {
    
    let keychain: KeychainHelper
    private let userDefaults = UserDefaults.standard
    
    static var users: [RegisterUserModel] = []
    static var curencyAccount: String?
    
    static var loggedInAccount: RegisterUserModel? {
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
    
    
    func login(phone: String?, password: String?) throws {
        var user = try LoginViewModel.checkIsNotEmpty(phone, password: password)
        try LoginViewModel.checkIsPasswordMatchesWithCredentials(phone, password)
        UserManager.loggedInAccount = user
    }
    
    func register(phone: String?, password: String?, confirmPassword: String?, currency: String?) throws {
        let user = try LoginViewModel.checkIstextfieldsAreNotEmpty(phoneNo: phone, password: password, confirmPassword: confirmPassword)
        print("USER: \(user)")
        let currency = try LoginViewModel.setAccountCurrency(account: currency)
        print("CURRENCY: \(currency)")
        try LoginViewModel.checkIsPhoneNumberUnique(phone)
        try LoginViewModel.checkIsPasswordSecure(password: password)
        try LoginViewModel.checkIsPasswordMatches(password: password, confirmPassword: confirmPassword)
        
        UserDefaultsHelper.saveUser(user)
        UserManager.loggedInAccount = user
        UserManager.users.append(user)
        UserManager.curencyAccount = currency
        print("USERS COUNT: \(UserManager.users.count)")
        print("ACCOUNT CURRENCY \(currency)")
    }
    
}
