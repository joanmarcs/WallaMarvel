//
//  MockSearchHeroesUseCase.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 7/3/25.
//

import Foundation
@testable import WallaMarvel

final class MockSearchHeroesUseCase: SearchHeroesUseCaseProtocol {
    var executeCalled = false
    var executeCallCount = 0
    var shouldFail = false
    var shouldThrowError = false
    
    func execute(startsWith: String) async throws -> [Hero] {
        executeCalled = true
        executeCallCount += 1
        
        if shouldFail {
            throw NSError(domain: "Test Error", code: -1, userInfo: nil)
        }
        
        return [Hero(id: 2, name: "Iron Man", thumbnail: HeroImage(url: ""), description: "")]
    }
}
