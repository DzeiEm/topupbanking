
import Foundation

enum APIEndpoint {
    
    case registerUser
    case createAccount
    case getAllUsers
    case getAllTransactions
//    case getUserTokenBy(id: String)
//    case getUserByPhone(number: String)
//    case getAllAccounts
//    case getAccountBy(id: String)
//    case getAllTransactions
//    case getTransactionBy(id: String)
   
    var url: URL? {
        switch self {
        case .registerUser:
            return makeURL(endpoint: "user")
        case .createAccount:
            return makeURL(endpoint: "account")
        case .getAllUsers:
            return makeURL(endpoint: "user")
        case .getAllTransactions:
            return makeURL(endpoint: "transaction")
//        case .getUserTokenBy(let id):
//            let id = URLQueryItem(name: byId , value: String(id))
//            return makeURL(endpoint: fetchAllUsers, queryItems: [id])
//        case .getUserByPhone(let number):
//            let number = URLQueryItem(name: userByPhoneNumer, value: String(number))
//            return makeURL(endpoint: fetchAllUsers, queryItems: [number] )
//        case .getAllAccounts:
//            return makeURL(endpoint: fetchAllAccounts)
//        case .getAccountBy(let id):
//            let id = URLQueryItem(name: byId, value: String(id))
//            return makeURL(endpoint: fetchAllAccounts, queryItems: [id])
//        case .getTransactionBy(let id):
//            let id = URLQueryItem(name: byId, value: String(id))
//            return makeURL(endpoint: "transaction")
        }
    }
}

private extension APIEndpoint {
    
    var BaseUrlString: String {
        "https://6368dedf15219b849608f700.mockapi.io/api/v3"
    }
    
    var searchQueryItem: String {
        "search"
    }
    
    var fetchAllUsers: String {
        "user"
    }
        
    var fetchAllAccounts: String {
        "account"
    }
    
    var byId: String {
        "id"
    }
    
    var userByPhoneNumer: String {
        "phoneNumber"
    }
    
    func makeURL(endpoint: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        let urlString = BaseUrlString + endpoint

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}

