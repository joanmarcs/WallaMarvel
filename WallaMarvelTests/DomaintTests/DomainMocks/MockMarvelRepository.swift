//
//  MockMarvelRepository.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
@testable import WallaMarvel

final class MockMarvelRepository: MarvelRepositoryProtocol {
    
    var shouldThrowError = false

    func getHeroes(offset: Int) async throws -> [Hero] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return [
            Hero(id: 1, name: "Iron Man", thumbnail: HeroImage(url: "ironman.png"), description: "A billionaire genius."),
            Hero(id: 2, name: "Spider-Man", thumbnail: HeroImage(url: "spiderman.png"), description: "Friendly neighborhood hero.")
        ]
    }

    func getHeroData(heroId: Int) async throws -> Hero {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return Hero(id: heroId, name: "Captain America", thumbnail: HeroImage(url: "cap.png"), description: "Super soldier.")
    }

    func getHeroComics(heroId: Int, offset: Int) async throws -> [Comic] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return [
            Comic(id: 101, title: "Iron Man #1", thumbnail: HeroImage(url: "ironman1.png")),
            Comic(id: 102, title: "Iron Man #2", thumbnail: HeroImage(url: "ironman2.png"))
        ]
    }
    
    func searchHeroes(startsWith: String) async throws -> [Hero] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }

        let heroes = [
            Hero(id: 1, name: "Iron Man", thumbnail: HeroImage(url: "ironman.png"), description: "A billionaire genius."),
            Hero(id: 2, name: "Spider-Man", thumbnail: HeroImage(url: "spiderman.png"), description: "Friendly neighborhood hero."),
            Hero(id: 3, name: "Hulk", thumbnail: HeroImage(url: "hulk.png"), description: "The strongest Avenger.")
        ]

        let filteredHeroes = heroes.filter { $0.name.lowercased().hasPrefix(startsWith.lowercased()) }

        return filteredHeroes
    }
}
