
import UIKit

final class LoginViewModel {
    
    static func checkIsTextfieldsAreNotEmpty(phoneNo: String?,
                                             password: String?) throws -> User? {
        
        guard let phoneNo = phoneNo,
              let password = password,
              !phoneNo.isEmpty,
              !password.isEmpty else {
            
            throw Errors.General.emptyFields
        }
        return User(phone: phoneNo, password: password, confirmPassword: nil)
    }
        
    static func checkIsPasswordMatchesWithCredentials(phoneNo: String?, password: String?) throws {
        
        guard let phoneNo = phoneNo else {
            throw Errors.General.emptyFields
        }
        guard password == KeychainHelper.getPasword(userPhoneKey: phoneNo) else {
            throw Errors.Login.credentialsDoNotMatch
        }
    }
}

