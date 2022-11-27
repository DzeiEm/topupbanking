
import Foundation

struct TokenResponse: Decodable {
   
    let isValid: Bool
    let expiryDate: Int?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum DataCodingKeys: String, CodingKey {
        case check
        case expires
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        isValid = try dataContainer.decode(Bool.self, forKey: .check)
        expiryDate = try? dataContainer.decode(Int.self, forKey: .expires)
    }
}
