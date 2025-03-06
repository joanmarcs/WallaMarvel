//
//  MockGetHeroComicsUseCase.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
@testable import WallaMarvel

class MockGetHeroComicsUseCase: GetHeroComicsUseCaseProtocol {
    var shouldThrowError = false
    var comics: [Comic] = [
        Comic(id: 101, title: "Iron Man #1", thumbnail: HeroImage(url: "ironman1.png")),
        Comic(id: 102, title: "Iron Man #2", thumbnail: HeroImage(url: "ironman2.png"))
    ]

    func execute(heroId: Int, offset: Int) async throws -> [Comic] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return comics
    }
}
