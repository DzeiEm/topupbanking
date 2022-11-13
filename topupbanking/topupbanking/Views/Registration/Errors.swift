
import Foundation

class Errors {
    
    enum RegistrationError: Error {
        case weakPassword
        case passwordDoNotMatch
        
        var error: String {
            switch self {
            case .weakPassword:
                return "Password is too weak 😢"
            case .passwordDoNotMatch:
                return "Passwords do not match 💁‍♀️"
            }
        }
    }
    
    enum LoginError: Error {
        case credentialsDoNotMatch
        
        var error: String {
            switch self {
            case .credentialsDoNotMatch:
                return " Username or password is incorect 😬 "
            }
        }
    }
    
    enum General: Error {
        case emptyFields
        case userAlreadyExist
        case unexpectedError
        
        var error: String {
            switch self {
            case .emptyFields:
                return "Fields connot be empty 🫠"
            case .userAlreadyExist:
                return "User already exist 🥵"
            case .unexpectedError:
                return "Unexpected error appears 😱"
            }
        }
        
        enum Secure: Error {
            case containsNumbers
            case containsLowerCases
            case containsUpperCases
            case containsRequiredPasswordLength
            
            var error: String {
                switch self {
                case .containsNumbers:
                    return "Password should contains numbers 1️⃣"
                case .containsLowerCases:
                    return "Password should contains lower case letters 🔤"
                case .containsUpperCases:
                    return "Password should contains upper case letters 🆙"
                case .containsRequiredPasswordLength:
                    return "Password should contain at lest 8 characters 8️⃣"
                }
            }
        }
    }
}
