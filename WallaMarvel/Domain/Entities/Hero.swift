//
//  Hero.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

struct Hero: Decodable {
    let id: Int
    let name: String
    let thumbnail: HeroImage
    let description: String
    
    init(id: Int, name: String, thumbnail: HeroImage, description: String) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
    }
}
