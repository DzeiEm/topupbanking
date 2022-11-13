

import Foundation
import UIKit

final class UserManager {
    
    static var users = [User]()
    
    static var loggedInAccount: User? {
        willSet(newProfile) {
            print("About to set username", newProfile?.username ?? "nil" )
        }
        didSet {
            print("About to set username", loggedInAccount?.username ?? "nil" )
        }
    }
    
    static func register(phonenumber: String?, password: String?, confirmPassword: String?) throws {
    
      
    }
    
    static func login(phonenumber: String?,password: String?) throws {
        
     
    
    }
}

