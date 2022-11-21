
import UIKit

class LoginViewModel {
    
    let userManager = UserManager()
    
    //MARK: - phone number
    
    static func checkIsNotEmpty(_ phoneNo: String?, password: String?) throws -> RegisterUserModel {
        
        guard let phoneNo = phoneNo,
              let password = password,
              !phoneNo.isEmpty,
              !password.isEmpty else {
            
            throw Errors.General.emptyFields
        }
        
        return RegisterUserModel(phone: phoneNo, password: password)
    }
    
    static func setAccountCurrency(account: String?) -> String {
        
        guard let account = account else {
            return "EUR"
        }
        return account
    }
    
    static func checkIsPasswordMatchesWithCredentials(_ phoneNo: String?, _ password: String?) throws {
        guard let phoneNo = phoneNo else {
            throw Errors.General.emptyFields
        }
        guard password == KeychainHelper.getPasword(phoneNo: phoneNo) else {
            throw Errors.LoginError.credentialsDoNotMatch
        }
    }
}

extension LoginViewModel {
    
    // MARK: - Password
    
    static func checkIstextfieldsAreNotEmpty(phoneNo: String?,
                                             password: String?,
                                             confirmPassword: String?) throws -> RegisterUserModel {
         
        guard let phoneNo = phoneNo,
              let password = password,
              let confirmPassword = confirmPassword,
              !phoneNo.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty else {
            
            throw Errors.General.emptyFields
        }
         return RegisterUserModel(phone: phoneNo, password: password, confirmPassword: confirmPassword)
     }
    
    static func checkIsPhoneNumberUnique(_ phoneNo: String?) -> Bool {
        return UserManager.users.contains(where: { number in
            number.phone == phoneNo
        }) ?? false
    }
    
    
    static func setOneFormatToPhoneNO(_ phone: String) {
//
//        let coutryCode = "+370"
//        let numberEight = "8"
//
//        let removeCharacters: Set<String> = ["+370", "8"]
//
//        if phone.starts(with: coutryCode) {
//            phone.count == 11
//            phone.removeAll(where: {_ in phone.elementsEqual(coutryCode)})
//
//        } else {
//            print(" Incorrect phone number")
//        }
//        if phone.starts(with: numberEight) {
//            phone.count == 9
//        } else {
//            print(" Incorrect phone number")
//        }
    }
   
    static func checkIsPasswordSecure(password: String?) throws {
       
        guard let password = password else {
            return
        }
         
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
