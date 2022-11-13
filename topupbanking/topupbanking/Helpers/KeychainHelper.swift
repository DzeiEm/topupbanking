
import Foundation
import KeychainSwift

class KeychainHelper {
    
    static var keychain = KeychainSwift()
    
    static func savePassword(user: User) {
        keychain.set(user.username, forKey: user.password)
    }
    
    static func getPasword(usernameKey: String) -> String? {
        keychain.get(usernameKey)
    }
}

