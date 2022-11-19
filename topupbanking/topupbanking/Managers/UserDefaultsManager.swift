
import UIKit
import Foundation

class UserDefaultsManager {
    
    enum UserDefaultsKey: String {
    
        case userAccounts = "UserAccounts"
        case currentLoggedinUser = "CurentltLoggedinUser"
    }
    
    private static var userDefaults: UserDefaults {
        UserDefaults.standard
    }
            
    static var currentlyLoggedInAccount: User? {
        get {
            guard let currentUser = userDefaults.object(forKey: UserDefaultsKey.currentLoggedinUser.rawValue) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode(User.self, from: currentUser)

        } set {
            let currentUser = try? JSONEncoder().encode(newValue)
            userDefaults.set(currentUser, forKey: UserDefaultsKey.currentLoggedinUser.rawValue)
        }
        
    }

    static var users: [User]? {
        get {
            guard let userAccounts = userDefaults.object(forKey: UserDefaultsKey.userAccounts.rawValue) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode([User].self, from: userAccounts)

        } set {
            let userAccounts = try? JSONEncoder().encode(newValue)
            userDefaults.set(userAccounts, forKey: UserDefaultsKey.userAccounts.rawValue)
        }
  
    }
    
    static func saveUserAccount(_ user: User , _ password: String) {
        guard users != nil else {
            users = [user]
            return
        }
        
        users?.append(user)
        KeychainHelper.savePassword(password, phoneNo: user.phone)
    }
}


extension UserDefaultsManager {
    
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

