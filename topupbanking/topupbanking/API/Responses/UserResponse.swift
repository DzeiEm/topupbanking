
import UIKit

struct UserResponse: Decodable {
    
        let id: String
        let phoneNumber: String
        let password: String
        let accessToken: String?
        let expiresIn: Double?
}
