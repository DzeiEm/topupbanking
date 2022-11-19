
import Foundation

final class RegistrationViewModel {
   
   static func checkIstextfieldsAreNotEmpty(number: String?, password: String?, confirmPassword: String?) throws -> User {
        
       guard let number = number,
             let password = password,
             let confirmPassword = confirmPassword,
             !number.isEmpty,
             !password.isEmpty,
             !confirmPassword.isEmpty else {
           
           throw Errors.General.emptyFields
       }
        return User(phone: number, password: password, confirmPassword: confirmPassword)
    }
    
    static func checkIsPhoneNumberUnique(_ phone: String) -> Bool {
        
        return UserDefaultsHelper.
    }
    
   static func isPasswordSecure(password: String) throws {
        
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
    
    func isPassworsMatch(password: String?, confirmPassword: String?) throws {
        
        if password != confirmPassword {
            throw Errors.RegistrationError.passwordDoNotMatch
        }
        return
    }
}

extension RegistrationViewModel {
    
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



