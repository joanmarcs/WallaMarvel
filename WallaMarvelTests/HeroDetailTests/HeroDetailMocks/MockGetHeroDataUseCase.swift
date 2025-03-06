//
//  MockGetHeroDataUseCase.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
@testable import WallaMarvel

class MockGetHeroDataUseCase: GetHeroDataUseCaseProtocol {
    var shouldThrowError = false
    var hero: Hero = Hero(id: 1, name: "Iron Man", thumbnail: HeroImage(url: "ironman.png"), description: "Billionaire genius")

    func execute(heroId: Int) async throws -> Hero {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return hero
    }
}
