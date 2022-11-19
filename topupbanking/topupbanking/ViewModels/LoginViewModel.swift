
import UIKit

class LoginViewModel {
    
    static var users = [User]()
    
    static func setCurrentLoggedinUser(_ user: User) {
        UserDefaultsManager.currentlyLoggedInAccount = user
    }
    
    static func validateLogin() {
        
    }
    
    static func validateRegistration() {
        
    }
}


extension LoginViewModel {
    
    //MARK: - phone number
    
    static func checkIsNotEmpty(_ phoneNo: String?, password: String?) throws -> User {
        
        guard let phoneNo = phoneNo,
              let password = password,
              !phoneNo.isEmpty,
              !password.isEmpty else {
            
            throw Errors.General.emptyFields
        }
        
        return User(phone: phoneNo, password: password)
    }
    
    static func checkIsPasswordMatchesWithCredentials(_ phoneNo: String?, _ password: String?) throws {
        guard password == KeychainHelper.getPasword(phoneNo: phoneNo) else {
            throw Errors.LoginError.credentialsDoNotMatch
        }
    }
}

extension LoginViewModel {
    
    // MARK: - Password
    
    static func checkIstextfieldsAreNotEmpty(phoneNo: String?,
                                             password: String?,
                                             confirmPassword: String?) throws -> User {
         
        guard let phoneNo = phoneNo,
              let password = password,
              let confirmPassword = confirmPassword,
              !phoneNo.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty else {
            
            throw Errors.General.emptyFields
        }
         return User(phone: phoneNo, password: password, confirmPassword: confirmPassword)
     }
    
    static func checkIsPhoneNumberUnique(_ phoneNo: String?) -> Bool {
        
        guard let phoneNumbers = UserDefaultsManager.users else { return false }
        
        return phoneNumbers.contains { number in
            number.phone == phoneNo
        }
    }
   
    static func checkIsPasswordSecure(password: String) throws {
         
         guard containsNumbers(password) else {
             throw Errors.Secure.containsNumbers
         }
         guard containsLowerCase(password) else {
             throw Errors.Secure.containsLowerCases
         }
         guard containsUpperCase(password) else {
             throw Errors.Secure.containsUpperCases
         }
         guard containsRequiredPasswordLength(password) else {
             throw Errors.Secure.containsRequiredPasswordLength
         }
     }
    
    static func checkIsPasswordMatches(password: String?, confirmPassword: String?) throws {
        
        if password != confirmPassword {
            throw Errors.RegistrationError.passwordDoNotMatch
        }
        return
    }
    
    private static func containsUpperCase(_ password: String) -> Bool {
        password.contains(where: { letter in
            letter.isUppercase
        })
    }
    
    private static func containsLowerCase(_ password: String) -> Bool {
        password.contains(where: { letter in
            letter.isLowercase
        })
    }
    
    private static func containsNumbers(_ password: String) -> Bool {
        password.contains(where: { letter in
            letter.isNumber
        })
    }
    
    private static func containsRequiredPasswordLength(_ password: String) -> Bool {
        password.count >= 8 ? true : false
    }
}
