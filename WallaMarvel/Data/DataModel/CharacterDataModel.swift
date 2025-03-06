import Foundation

struct CharacterDataModel: Decodable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
    
    func toDomain() -> Hero {
        return Hero(id: id, name: name, thumbnail: thumbnail.toDomain())
    }
}
