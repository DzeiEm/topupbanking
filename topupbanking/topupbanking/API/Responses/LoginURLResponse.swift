
import Foundation

struct LoginURLResponse: Decodable {
    
    let loginURL: String

    enum CodingKeys: String, CodingKey {
        case data
    }

    enum DataCodingKeys: String, CodingKey {
        case loginUrl
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        loginURL = try dataContainer.decode(String.self, forKey: .loginUrl)
    }
}
