
import Foundation

class RegisterViewModel {
    
   static func checkIstextfieldsAreNotEmpty(phoneNo: String?,
                                            password: String?,
                                            confirmPassword: String?) throws -> UserRequest {
        
       guard let phoneNo = phoneNo,
             let password = password,
             let confirmPassword = confirmPassword,
             !phoneNo.isEmpty,
             !password.isEmpty,
             !confirmPassword.isEmpty
       else {
           throw Errors.General.emptyFields
       }
       return UserRequest(phoneNumber: phoneNo, password: password)
    }
    
    static func isPhoneNumberIsTaken(_ phoneNo: String?) -> Bool {
        
        guard let phoneNo = phoneNo else {
            return false
        }
    
        return UserManager.users.contains(where: { number in
            number.phoneNumber == phoneNo
        })
    }
    
    static func setPhoneNumber(_ number: String?) throws {
        let coutryCodePrefix = "+370"
        let internalPrefix = "8"
        var numberAcc = number
        
        guard let number = number else {
            return
        }
        
        if number.hasPrefix(coutryCodePrefix) && number.count == 11 {
           numberAcc = number.deletingPrefix(coutryCodePrefix)
        }
        
        if number.hasPrefix(internalPrefix) && number.count == 8 {
           numberAcc = number.deletingPrefix(internalPrefix)
        }
        
        throw Errors.Phone.incorrectPhone
    }
    
    static func setAccountCurrency(account: String?) -> String {
        
        guard let account = account else {
            return ""
        }
      
        if account.elementsEqual("") {
            return "EUR"
        }
        return account
    }
    
    static func isPasswordSecure(_ password: String?) throws {
       
       guard let password = password else {
           return
       }
        guard RegisterViewModel.containsNumbers(password) else {
            throw Errors.Registration.containsNumbers
        }
        guard RegisterViewModel.containsLowerCase(password) else {
            throw Errors.Registration.containsLowerCases
        }
        guard RegisterViewModel.containsUpperCase(password) else {
            throw Errors.Registration.containsUpperCases
        }
        guard RegisterViewModel.containsRequiredPasswordLength(password) else {
            throw Errors.Registration.containsRequiredPasswordLength
        }
    }
    
    static func isPassworsMatch(_ password: String?, _ confirmPassword: String?) throws {
        
        if password != confirmPassword {
            throw Errors.Registration.passwordDoNotMatch
        }
        return
    }
    
}


extension RegisterViewModel {
    
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


extension String {
    
    func deletingPrefix(_ prefix: String) -> String {
           guard self.hasPrefix(prefix) else { return self }
           return String(self.dropFirst(prefix.count))
    }
}


