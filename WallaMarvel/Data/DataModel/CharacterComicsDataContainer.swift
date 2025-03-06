//
//  CharacterComicsDataContainer.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

struct CharacterComicsDataContainer: Decodable {
    let count: Int
    let limit: Int
    let offset: Int
    let comics: [ComicDataModel]
    
    enum CodingKeys: String, CodingKey {
        case data
        case count, limit, offset, comics = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.count = try data.decode(Int.self, forKey: .count)
        self.limit = try data.decode(Int.self, forKey: .limit)
        self.offset = try data.decode(Int.self, forKey: .offset)
        
        self.comics = try data.decode([ComicDataModel].self, forKey: .comics)
    }
    
    init (count: Int, limit: Int, offset: Int, comics: [ComicDataModel]) {
        self.count = count
        self.limit = limit
        self.offset = offset
        self.comics = comics
    }
}
