import Foundation

struct CharacterDataModel: Decodable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
    let description: String

    
    func toDomain() -> Hero {
        return Hero(id: id, name: name, thumbnail: thumbnail.toDomain(), description: description)
    }
}
