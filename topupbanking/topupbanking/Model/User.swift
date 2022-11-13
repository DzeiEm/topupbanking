
import Foundation

class User: Codable {
    var username: String
    var password: String
    var confirmPassword: String?
    
    init(username: String, password: String, confirmPassword: String?) {
        self.username = username
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
