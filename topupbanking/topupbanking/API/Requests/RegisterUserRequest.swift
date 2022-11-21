
import Foundation

struct RegisterUserRequest: Encodable {
    let id: String
    let phone: String
    let password: String
   // let confirmPassword: String?
    let accountCurrency: String
    let balance: String
    
}

