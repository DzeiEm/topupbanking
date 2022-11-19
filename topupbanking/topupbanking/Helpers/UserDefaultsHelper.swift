
import UIKit
import Foundation
import KeychainSwift


class UserDefaultsHelper {
    
    enum UserDefaultsKey {
       
        case userAccounts
    }
    
    private static var userDefaults: UserDefaults {
        UserDefaults.standard
    }
    
    private static let keyChain = KeychainSwift()
        
    static var currentlyLoggedInAccount: User? {
        get {
            guard let currentUser = userDefaults.object(forKey: UserDefaultsKey.currentlyLoggedinUser) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode(User.self, from: currentUser)
            
        } set {
            let currentUser = try? JSONEncoder().encode(newValue)
            userDefaults.set(currentUser, forKey: UserDefaultsKey.currentlyLoggedinUser)
        }
    }
    
    static var users: [User?] {
        get {
            guard let userAccounts = userDefaults.object(forKey: UserDefaultsKey.users) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode(User.self, from: userAccounts)
            
        } set {
            let userAccounts = try? JSONEncoder().encode(newValue)
            userDefaults.set(userAccounts, forKey: UserDefaultsKey.users)
        }
    }
    
   
    static func saveUserAccount(_ user: User, _password: String) {
        guard users != nil else {
            users = [user]
            return
        }
    
    }
    
    static func savePAssword(_ password: String, phoneNo: String) {
        keyChain.set(<#T##value: String##String#>, forKey: <#T##String#>)
    }
    
}


















extension UserDefaultsHelper {
    
    static var userAccounts: [User]? {
        get {
            object(forKey: .users, type: [User].self) as! [User]?
        }
        set {
            saveObject(object: newValue, forKey: .users)
        }
    }

}


// MARK: - Helpers

extension UserDefaultsHelper {
    
    // MARK: - SAVE
    
    static func save(value: Codable, forKey: UserDefaultsKey) {
        userDefaults.set(value, forKey: forKey.rawValue)
    }
    
    private static func saveObject<T: Encodable>(object: T, forKey: UserDefaultsKey) {
        let data = try? JSONEncoder().encode(object)
        userDefaults.set(data, forKey: forKey.rawValue)
    }
    
    // MARK: - RETRIEVE
    
    private static func string(forKey: UserDefaultsKey) -> String? {
        userDefaults.value(forKey: forKey.rawValue) as? String
    }
    
    private static func int(forKey: UserDefaultsKey) -> Int {
        userDefaults.integer(forKey: forKey.rawValue)
    }
    
    static func bool(forKey: UserDefaultsKey) -> Bool {
        userDefaults.bool(forKey: forKey.rawValue)
    }
    
    private static func object<T: Decodable>(forKey: UserDefaultsKey, type: T.Type) -> Any? {
        guard let data = userDefaults.data(forKey: forKey.rawValue) else {
            return nil
        }
        
        let object = try? JSONDecoder().decode(type, from: data)
        return object
    }
}

