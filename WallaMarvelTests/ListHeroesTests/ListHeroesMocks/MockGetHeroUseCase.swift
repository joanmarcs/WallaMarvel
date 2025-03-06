//
//  MockGetHeroUseCase.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
@testable import WallaMarvel

class MockGetHeroesUseCase: GetHeroesUseCaseProtocol {
    var shouldThrowError = false
    var returnedHeroes: [Hero] = [
        Hero(id: 1, name: "Iron Man", thumbnail: HeroImage(url: "ironman.png"), description: "Billionaire genius"),
        Hero(id: 2, name: "Spider-Man", thumbnail: HeroImage(url: "spiderman.png"), description: "Friendly neighborhood hero")
    ]
    
    func execute(offset: Int) async throws -> [Hero] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return returnedHeroes
    }
}
