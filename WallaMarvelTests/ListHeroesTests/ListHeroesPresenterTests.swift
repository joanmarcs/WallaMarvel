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
    var mockGetHeroesUseCase: MockGetHeroesUseCase!
    var mockSearchHeroesUseCase: MockSearchHeroesUseCase!
    var mockNavigator: MockNavigator!
    var mockUI: MockListHeroesUI!

    override func setUp() {
        super.setUp()
        mockGetHeroesUseCase = MockGetHeroesUseCase()
        mockNavigator = MockNavigator()
        mockSearchHeroesUseCase = MockSearchHeroesUseCase()
        mockUI = MockListHeroesUI()
        
        presenter = ListHeroesPresenter(getHeroesUseCase: mockGetHeroesUseCase,
                                        searchHeroesUseCase: mockSearchHeroesUseCase, navigator: mockNavigator)
        presenter.ui = mockUI
    }

    override func tearDown() {
        mockGetHeroesUseCase = nil
        mockNavigator = nil
        mockUI = nil
        presenter = nil
        mockSearchHeroesUseCase = nil
        super.tearDown()
    }

    func testGetHeroes_shouldUpdateUI_whenUseCaseSucceeds() async {
        mockGetHeroesUseCase.shouldThrowError = false
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
        mockGetHeroesUseCase.shouldThrowError = true
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
    
    func testSearchHeroes_shouldUpdateUI_whenUseCaseSucceeds() async {
        mockSearchHeroesUseCase.shouldThrowError = false
        let expectation = expectation(description: "Search results should be loaded")

        presenter.searchHeroes(searchText: "Iron")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2.0)

        XCTAssertEqual(mockUI.heroesUpdated.count, 1)
        XCTAssertEqual(mockUI.heroesUpdated.first?.name, "Iron Man")
    }

    func testUpdateSearchText_shouldShowLoadingIndicator() {
        presenter.updateSearchText("Hulk")
        XCTAssertTrue(mockUI.showLoadingIndicatorCalled)
    }
}

