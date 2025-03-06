import Foundation

struct Thumbnail: Decodable {
    let path: String
    let `extension`: String
    
    func toDomain() -> HeroImage {
        let url = "\(path).\(self.extension)"
        return HeroImage(url: url)
    }
}
