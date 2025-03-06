//
//  HeroDetailPresenterTests.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import XCTest
@testable import WallaMarvel

final class HeroDetailPresenterTests: XCTestCase {

    var presenter: HeroDetailPresenter!
    var mockHeroUseCase: MockGetHeroDataUseCase!
    var mockComicsUseCase: MockGetHeroComicsUseCase!
    var mockUI: MockHeroDetailUI!

    override func setUp() {
        super.setUp()
        mockHeroUseCase = MockGetHeroDataUseCase()
        mockComicsUseCase = MockGetHeroComicsUseCase()
        mockUI = MockHeroDetailUI()
        
        presenter = HeroDetailPresenter(heroId: 1, getHeroDataUseCase: mockHeroUseCase, getHeroComicsUseCase: mockComicsUseCase)
        presenter.ui = mockUI
    }

    override func tearDown() {
        mockHeroUseCase = nil
        mockComicsUseCase = nil
        mockUI = nil
        presenter = nil
        super.tearDown()
    }

    func testFetchHeroData_shouldUpdateUI_whenUseCaseSucceeds() async {
        mockHeroUseCase.shouldThrowError = false
        let expectation = expectation(description: "Hero data should be loaded")

        presenter.fetchHeroData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2.0)

        XCTAssertNotNil(mockUI.updatedHero)
        XCTAssertEqual(mockUI.updatedHero?.name, "Iron Man")
    }

    func testFetchHeroData_shouldShowError_whenUseCaseFails() async {
        mockHeroUseCase.shouldThrowError = true
        let expectation = expectation(description: "Error message should be displayed")

        presenter.fetchHeroData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2.0)

        XCTAssertEqual(mockUI.lastErrorMessage, "Failed to load hero details.")
    }

    func testGetHeroComics_shouldUpdateUI_whenUseCaseSucceeds() async {
        mockComicsUseCase.shouldThrowError = false
        let expectation = expectation(description: "Comics should be loaded")

        presenter.getHeroComics()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2.0)

        XCTAssertEqual(mockUI.updatedComics.count, 2)
        XCTAssertEqual(mockUI.updatedComics.first?.title, "Iron Man #1")
    }
}
