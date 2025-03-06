//
//  ListHeroesPresenterTests.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import XCTest
@testable import WallaMarvel

final class ListHeroesPresenterTests: XCTestCase {

    var presenter: ListHeroesPresenter!
    var mockUseCase: MockGetHeroesUseCase!
    var mockNavigator: MockNavigator!
    var mockUI: MockListHeroesUI!

    override func setUp() {
        super.setUp()
        mockUseCase = MockGetHeroesUseCase()
        mockNavigator = MockNavigator()
        mockUI = MockListHeroesUI()
        
        presenter = ListHeroesPresenter(getHeroesUseCase: mockUseCase, navigator: mockNavigator)
        presenter.ui = mockUI
    }

    override func tearDown() {
        mockUseCase = nil
        mockNavigator = nil
        mockUI = nil
        presenter = nil
        super.tearDown()
    }

    func testGetHeroes_shouldUpdateUI_whenUseCaseSucceeds() async {
        mockUseCase.shouldThrowError = false
        let expectation = expectation(description: "Heroes data should be loaded")

        presenter.getHeroes()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2.0)

        XCTAssertEqual(mockUI.heroesUpdated.count, 2)
        XCTAssertEqual(mockUI.heroesUpdated.first?.name, "Iron Man")
    }

    func testGetHeroes_shouldShowError_whenUseCaseFails() async {
        mockUseCase.shouldThrowError = true
        let expectation = expectation(description: "Error message should be displayed")

        presenter.getHeroes()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2.0)

        XCTAssertEqual(mockUI.lastErrorMessage, "Failed to load heroes.")
    }

    func testDidSelectHero_shouldNavigateToDetail() {
        let hero = Hero(id: 99, name: "Thor", thumbnail: HeroImage(url: "thor.png"), description: "God of Thunder")

        presenter.didSelectHero(hero)

        XCTAssertTrue(mockNavigator.didNavigateToHeroDetail)
        XCTAssertEqual(mockNavigator.navigatedHeroId, 99)
    }
}

