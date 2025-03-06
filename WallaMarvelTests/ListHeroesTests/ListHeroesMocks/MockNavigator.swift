//
//  MockNavigator.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
@testable import WallaMarvel

class MockNavigator: ListHeroesNavigatorProtocol {
    var didNavigateToHeroDetail = false
    var navigatedHeroId: Int?

    func navigateToHeroDetail(heroId: Int) {
        didNavigateToHeroDetail = true
        navigatedHeroId = heroId
    }
}
