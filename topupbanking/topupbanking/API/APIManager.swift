
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
    
    private var urlSession: URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = [
            HeaderKey.headerContent: HeaderValue.content
        ]

        return URLSession(configuration: sessionConfiguration)
    }

    
//
//    let userManager: UserManager
//
//    private var userIdentifier: Int? {
//        userManager.getUserId()
//    }
}

extension APIManager {
    
    func registerUser(_ user: UserRequest, completion: @escaping(Result<UserRequest, APIError>) -> Void) {
      
        guard let url = APIEndpoint.registerUser.url  else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        print("URL: \(url)")
        
        let registerUserRequest = UserRequest(phoneNumber: user.phoneNumber, password: user.password)
        guard let requestBodyJSON = try? encoder.encode(registerUserRequest) else {
            completion(.failure(APIError.serializationError))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post
        urlRequest.httpBody = requestBodyJSON
        
        urlSession.dataTask(with: urlRequest,
                            completionHandler: { data, _, error in
            
            if let error = error {
                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
            }
            guard let data = data,
                  let userResponse = try? decoder.decode(UserResponse.self, from: data)
            else {
                completion(.failure(.parsingError))
                return
            }
            completion(.success(UserRequest(phoneNumber: userResponse.phoneNumber, password: userResponse.password)))
        }).resume()
    }
    
//    func getUserbyPhone(_ number: String, completion: @escaping (Result<User, APIError>) -> Void) {
//        guard let url = APIEndpoint.getUserByPhone(number: number).url else {
//            completion(.failure(APIError.invalidURL))
//            return
//        }
//
//        urlSession.dataTask(with: url) { data, _, error in
//            if let error {
//                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
//            }
//            guard let data,
//                  let usersResponse = try? decoder.decode([UserResponse].self, from: data)
//            else {
//                completion(.failure(APIError.parsingError))
//            }
//            guard usersResponse.count > 0 else {
//                completion(.failure(APIError.userNotFound))
//                return
//            }
//            completion(.success(usersResponse[0].id)
//            )}.resume()
//    }
 
}


extension APIManager {
    
//    func getTransactions(completion: @escaping (Result<[Transaction], APIError>) -> Void) {
//        guard let url = APIEndpoint.getTransactions.url else {
//            completion(.failure(APIError.invalidURL))
//            return
//        }
//        urlSession.dataTask(with: url, completionHandler: { data, _, error in
//            if let error = error {
//                completion(.failure(APIError.requestError(reason: error.localizedDescription)))
//                return
//            }
//            guard let data = data,
//                  let allTransactions = try? decoder.decode([TransactionsdResponse].self, from: data)
//            else {
//                completion(.failure(APIError.parsingError))
//                return
//            }
//            completion(.success(allTransactions.compactMap({ transaction in
//           // TODO: Transaction model
//                
//            })))
//        }).resume()
//    }
}
