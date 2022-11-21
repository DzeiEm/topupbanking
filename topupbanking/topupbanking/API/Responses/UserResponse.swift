
import UIKit

struct UserResponse: Decodable {
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum DataCodingKeys: String, CodingKey {
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dataContainer = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        self.id = try dataContainer.decode(Int.self, forKey: .id)
    }
    
}
