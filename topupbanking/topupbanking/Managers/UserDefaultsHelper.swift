
import UIKit
import Foundation

class UserDefaultsHelper {
    
    enum UserDefaultsKey: String {
        case users
    }
    
    private static var userDefaults: UserDefaults {
        UserDefaults.standard
    }
    
    static func saveUser(_ user: UserRequest) {
        var savedUsers: [UserRequest] = []
        savedUsers = users ?? []
        KeychainHelper.savePassword(user)
        
        savedUsers.append(user)
        users = savedUsers
    }
}

extension UserDefaultsHelper {
    
    static var users: [UserRequest]? {
        get {
            object(forKey: .users, type: [UserRequest].self) as! [UserRequest]?
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

