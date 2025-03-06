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
}
