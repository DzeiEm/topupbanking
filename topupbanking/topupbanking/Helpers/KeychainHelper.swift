
import Foundation
import KeychainSwift

class KeychainHelper {
    
    static var keychain = KeychainSwift()
    
    static func savePassword(_ password: String, phoneNo: String) {
        keychain.set(password, forKey: phoneNo)
    }
    
    static func getPasword(phoneNo: String) -> String? {
        keychain.get(phoneNo)
    }
}

