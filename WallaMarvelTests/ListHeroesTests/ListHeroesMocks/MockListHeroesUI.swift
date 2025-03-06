//
//  MockListHeroesUI.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
@testable import WallaMarvel

class MockListHeroesUI: ListHeroesUI {
    var heroesUpdated: [Hero] = []
    var lastErrorMessage: String?

    func update(heroes: [Hero]) {
        heroesUpdated = heroes
    }

    func showError(message: String) {
        lastErrorMessage = message
    }
}
