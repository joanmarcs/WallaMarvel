//
//  MockHeroDetailUI.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
@testable import WallaMarvel

final class MockHeroDetailUI: HeroDetailUI {
    var updatedHero: Hero?
    var updatedComics: [Comic] = []
    var lastErrorMessage: String?

    func updateHeroDetail(hero: Hero) {
        updatedHero = hero
    }

    func updateComics(comics: [Comic]) {
        updatedComics = comics
    }

    func showError(message: String) {
        lastErrorMessage = message
    }
    
    func showLoadingIndicator() {
    }
    
    func hideLoadingIndicator() {
    }

}
