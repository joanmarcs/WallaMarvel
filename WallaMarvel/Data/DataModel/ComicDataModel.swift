//
//  ComicDataModel.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

struct ComicDataModel: Decodable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
    
    public func toDomain() -> Comic {
        return Comic(id: id, title: title, thumbnail: thumbnail.toDomain())
    }
}
