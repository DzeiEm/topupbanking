
import Foundation

class User: Codable {
    var phone: String
    var password: String
    var confirmPassword: String?
    
    init(phone: String, password: String, confirmPassword: String?) {
        self.phone = phone
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
