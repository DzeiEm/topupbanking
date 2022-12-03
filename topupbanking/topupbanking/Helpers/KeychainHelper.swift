
import Foundation
import KeychainSwift

class KeychainHelper {
    
    static var keychain = KeychainSwift()
    
    static func savePassword(_ user: UserRequest) {
        keychain.set(user.phoneNumber, forKey: user.password)
    }
    
    static func getPasword(userPhoneKey: String) -> String? {
        keychain.get(userPhoneKey)
    }
}
