
import Foundation

struct APIManager {
    
    private enum HTTPMethod {
        static let get = "GET"
    }
    
    private enum HeaderKey {
        static let headerContent = "Content-Type"
    }
    
    private enum HeaderValue {
        static let content = "application/json"
    }
    
    private var keychain: KeychainHelper { KeychainHelper() }
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private var urlSession: URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = [
            HeaderKey.headerContent: HeaderValue.content
        ]
        return URLSession(configuration: sessionConfiguration)
    }
}

extension APIManager {
    
    func getUsers() {
        //fetch user data
    }
    
    func getTransactions() {
        //fetch user transactions
    }
    
}
