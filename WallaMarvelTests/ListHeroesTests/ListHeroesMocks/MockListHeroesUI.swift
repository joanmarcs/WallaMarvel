//
//  MockListHeroesUI.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
@testable import WallaMarvel

final class MockListHeroesUI: ListHeroesUI {
    var heroesUpdated: [Hero] = []
    var lastErrorMessage: String?
    var removeHeroesCalled = false
    var showLoadingIndicatorCalled = false
    var hideLoadingIndicatorCalled = false

    func update(heroes: [Hero]) {
        heroesUpdated = heroes
    }

    func showError(message: String) {
        lastErrorMessage = message
    }
    
    func removeHeroes() {
        removeHeroesCalled = true
    }
    
    func showLoadingIndicator() {
        showLoadingIndicatorCalled = true
    }

    func hideLoadingIndicator() {
        hideLoadingIndicatorCalled = true
    }
}
