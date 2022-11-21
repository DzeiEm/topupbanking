
import Foundation

enum APIEndpoint {
    
    case registerUser
    case getUser
    case getAccount
    case getTransactions
    
    var url: URL? {
        switch self {
        case .registerUser:
            return makeURL(endpoint: "user")
        case .getUser:
            return makeURL(endpoint: "user")
        case .getAccount:
            return makeURL(endpoint: "account")
        case .getTransactions:
            return makeURL(endpoint: "transaction" )
        }
    }
}

extension APIEndpoint {
    private var BaseUrlString: String {
        "https://6368dedf15219b849608f700.mockapi.io/api/v3/"
    }

    private func makeURL(endpoint: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        let urlString = BaseUrlString + endpoint

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}

