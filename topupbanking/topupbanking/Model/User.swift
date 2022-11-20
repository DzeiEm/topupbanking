
import Foundation

struct User: Codable {
    
    var phone: String
    var password: String
    var confirmPassword: String?
    var accountCurrency: String?
    var balance: Double?
}
