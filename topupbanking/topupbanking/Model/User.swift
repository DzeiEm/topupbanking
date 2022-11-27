
import Foundation

class User {
    
    var phone: String
    var password: String
    var confirmPassword: String?
    
    init(phone: String, password: String, confirmPassword: String? = nil) {
        self.phone = phone
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
