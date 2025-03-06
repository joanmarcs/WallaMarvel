//
//  Comic.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

struct Comic: Decodable {
    let id: Int
    let title: String
    let thumbnail: HeroImage
    
    public init(id: Int, title: String, thumbnail: HeroImage) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
    }
}
