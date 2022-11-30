
import Foundation

class Errors {
    
    enum Registration: Error {
        case userAlreadyExist
        case weakPassword
        case passwordDoNotMatch
        case containsNumbers
        case containsLowerCases
        case containsUpperCases
        case containsRequiredPasswordLength
        
        var error: String {
            switch self {
            case .userAlreadyExist:
                return "User already exist 🥵"
            case .weakPassword:
                return "Password is too weak 😢"
            case .passwordDoNotMatch:
                return "Passwords do not match 💁‍♀️"
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
    
    enum Login: Error {
        case credentialsDoNotMatch
        case userNotFound
        
        var error: String {
            switch self {
            case .credentialsDoNotMatch:
                return " Username or password is incorect 😬 "
            case .userNotFound:
                return "User not found"
            }
        }
    }
    
    enum Phone: Error {
        case incorrectPhone
        
        var error: String {
            switch self {
            case .incorrectPhone:
                return "Incorrect phone number lenght"
            }
        }
    }
        
    enum General: Error {
        case emptyFields
        case unexpectedError
        
        var error: String {
            switch self {
            case .emptyFields:
                return "Fields connot be empty 🫠"
            case .unexpectedError:
                return "Unexpected error appears 😱"
            }
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
