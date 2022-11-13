
import Foundation

enum APIEndpoint {
    case getUsers
    case getTransactions
    
    var url: URL? {
        switch self {
//        case .getEpisodes:
//            return makeURL(endpoint: "episodes?series=breaking+bad")
//        case .getQuotes:
//            return makeURL(endpoint: "quotes")
//        case .getCharacters:
//            return makeURL(endpoint: "characters")
//        }
    }
}

extension APIEndpoint {
    private var BaseUrlString: String {
        "https://www.breakingbadapi.com/api/"
    }

    private func makeURL(endpoint: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        let urlString = BaseUrlString + endpoint

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}

