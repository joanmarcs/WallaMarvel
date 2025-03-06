//
//  HeroDetailUITests.swift
//  WallaMarvelUITests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import XCTest

final class HeroDetailUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testHeroDetailScreen_shouldDisplayCorrectly() {
        navigateToHeroDetail()
        
        let title = app.navigationBars.staticTexts.element
        XCTAssertTrue(title.waitForExistence(timeout: 10), "Hero title did not appear")

        let descriptionLabel = app.staticTexts[AccessibilityIdentifier.heroDescriptionLabel]
        let imageView = app.images[AccessibilityIdentifier.heroImageView]
        let comicsCollectionView = app.collectionViews[AccessibilityIdentifier.heroComicsCollectionView]

        XCTAssertTrue(descriptionLabel.exists, "Description label did not appear")
        XCTAssertTrue(imageView.exists, "Image did not appear")
        XCTAssertTrue(comicsCollectionView.exists, "Comoics did not appear")
    }
    
    private func navigateToHeroDetail() {
        let tableView = app.tables[AccessibilityIdentifier.heroesTableView]
        XCTAssertTrue(tableView.waitForExistence(timeout: 10), "La lista de héroes no se cargó")

        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 20), "La primera celda no apareció a tiempo")

        firstCell.tap()
    }
}
