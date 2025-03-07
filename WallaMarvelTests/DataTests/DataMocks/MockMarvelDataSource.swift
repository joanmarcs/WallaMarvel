//
//  MockMarvelDataSource.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
@testable import WallaMarvel

final class MockMarvelDataSource: MarvelDataSourceProtocol {
    var shouldThrowError = false

    func getHeroes(offset: Int) async throws -> CharacterDataContainer {
        if shouldThrowError {
            throw APIError.serverError
        }
        return CharacterDataContainer(count: 2, limit: 10, offset: offset, characters: [
            CharacterDataModel(id: 1, name: "Iron Man", thumbnail: Thumbnail(path: "ironman", extension: "png"), description: "A billionaire genius."),
            CharacterDataModel(id: 2, name: "Spider-Man", thumbnail: Thumbnail(path: "spiderman", extension: "png"), description: "Friendly neighborhood hero.")
        ])
    }

    func getHeroData(heroId: Int) async throws -> CharacterDataContainer {
        if shouldThrowError {
            throw APIError.serverError
        }
        return CharacterDataContainer(count: 1, limit: 10, offset: 0, characters: [
            CharacterDataModel(id: heroId, name: "Captain America", thumbnail: Thumbnail(path: "cap", extension: "png"), description: "Super soldier.")
        ])
    }

    func getHeroComics(heroId: Int, offset: Int) async throws -> CharacterComicsDataContainer {
        if shouldThrowError {
            throw APIError.serverError
        }
        return CharacterComicsDataContainer(count: 2, limit: 10, offset: offset, comics: [
            ComicDataModel(id: 101, title: "Iron Man #1", thumbnail: Thumbnail(path: "ironman1", extension: "png")),
            ComicDataModel(id: 102, title: "Iron Man #2", thumbnail: Thumbnail(path: "ironman2", extension: "png"))
        ])
    }
    
    func searchHeroes(startsWith: String) async throws -> CharacterDataContainer {
        if shouldThrowError {
            throw APIError.serverError
        }

        let heroes = [
            CharacterDataModel(id: 1, name: "Iron Man", thumbnail: Thumbnail(path: "ironman", extension: "png"), description: "A billionaire genius."),
            CharacterDataModel(id: 2, name: "Spider-Man", thumbnail: Thumbnail(path: "spiderman", extension: "png"), description: "Friendly neighborhood hero."),
            CharacterDataModel(id: 3, name: "Hulk", thumbnail: Thumbnail(path: "hulk", extension: "png"), description: "The strongest Avenger.")
        ]

        let filteredHeroes = heroes.filter { $0.name.lowercased().hasPrefix(startsWith.lowercased()) }

        return CharacterDataContainer(count: filteredHeroes.count, limit: 10, offset: 0, characters: filteredHeroes)
    }
}

