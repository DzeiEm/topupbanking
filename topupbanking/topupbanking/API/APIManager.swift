
import Foundation

struct APIManager {
    
    private enum HTTPMethod {
        static let get = "GET"
        static let post = "POST"
        static let delete = "DELETE"
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
    
    private let userManager = UserManager
    private var userIdentifier: Int? {
        
    }
    
    private var urlSession: URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = [
            HeaderKey.headerContent: HeaderValue.content
        ]
        return URLSession(configuration: sessionConfiguration)
    }
}

extension APIManager {
    
    func registerUser(_ user: RegisterUserModel, completion: @escaping(Result<Int, APIError>) -> Void) {
        
        guard let userIdentifier = userIdentifier else {
            completion(.failure(APIError.serializationError))
            return
        }
        
        guard let = APIEndpoint
                       
                        
                    
    }
    
    
    

    func getUsers(completion: @escaping (Result<[RegisterUserModel], APIError>) -> Void) {
        
        guard let url = APIEndpoint.getUser.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        urlSession.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
                return
            }
            guard let data = data,
                  let user = try? decoder.decode([UserResponse].self, from: data)
            else {
                completion(.failure(APIError.parsingError))
                return
            }
//            completion(.success(user.compactMap({ user in
               // TODO: User model
            })))
        }).resume()
    }
    
    func getTransactions(completion: @escaping (Result<[Transaction], APIError>) -> Void) {
        guard let url = APIEndpoint.getTransactions.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        urlSession.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
                return
            }
            guard let data = data,
                  let allTransactions = try? decoder.decode([TransactionsdResponse].self, from: data)
            else {
                completion(.failure(APIError.parsingError))
                return
            }
            //completion(.success(allTransactions.compactMap({ transaction in
           // TODO: Transaction model
                
            })))
        }).resume()
    }
    
}
