

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
    
        let userAccount = try RegistrationViewModel.validateLoginCredentials(<#T##self: RegistrationViewModel##RegistrationViewModel#>)

        if RegistrationValidation.isProfileIsTaken(profile.username) {
            throw AuthenticationError.General.userAlreadyExist
        }
        
        try RegistrationValidation.isPasswordSecure(password: profile.password)
        try RegistrationValidation.isPasswordMatch(password: profile.password, confirmPassword: profile.confirmPassword)
        
        UserDefaultsHelper.saveProfile(profile)
        ProfileManager.loggedInAccount = profile
        profiles.append(profile)
    }
    
    static func login(phonenumber: String?,password: String?) throws {
        
     
    
    }
}

