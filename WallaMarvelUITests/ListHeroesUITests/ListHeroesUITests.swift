//
//  ListHeroesUITests.swift
//  WallaMarvelUITests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import XCTest

final class ListHeroesUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testHeroesList_shouldDisplayDataCorrectly() {
        let tableView = app.tables[AccessibilityIdentifier.heroesTableView]
        XCTAssertTrue(tableView.waitForExistence(timeout: 5))
        
        let firstCell = tableView.cells.element(boundBy: 0)
        
        XCTAssertTrue(firstCell.waitForExistence(timeout: 2))
        XCTAssertNotEqual(firstCell.staticTexts.element.label, "", "Cell should have text")
    }
    
    func testSelectingHero_shouldTriggerNavigation() {
        let tableView = app.tables[AccessibilityIdentifier.heroesTableView]
        let firstCell = tableView.cells.element(boundBy: 0)
        
        XCTAssertTrue(firstCell.waitForExistence(timeout: 20), "First cell not appeared in time")
        
        firstCell.tap()
        
        let detailLabel = app.staticTexts[AccessibilityIdentifier.heroAppearsInLabel]
        XCTAssertTrue(detailLabel.waitForExistence(timeout: 2), "Detail view did not appear")
        
        let navigationBar = app.navigationBars.element
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 5), "Navigation bar not appeared")
        XCTAssertNotEqual(navigationBar.identifier, "", "Screen title should not be empty")
    }
}

