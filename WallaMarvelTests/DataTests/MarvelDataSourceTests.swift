//
//  MarvelDataSourceTests.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import XCTest
@testable import WallaMarvel

class MarvelDataSourceTests: XCTestCase {
    
    var mockAPIClient: MockAPIClient!
    var dataSource: MarvelDataSource!

    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        dataSource = MarvelDataSource(apiClient: mockAPIClient)
    }

    override func tearDown() {
        mockAPIClient = nil
        dataSource = nil
        super.tearDown()
    }

    func testGetHeroes_shouldCallAPIClient() async throws {
        // Given
        mockAPIClient.shouldThrowError = false

        // When
        let result = try await dataSource.getHeroes(offset: 0)

        // Then
        XCTAssertEqual(result.characters.count, 2)
    }

    func testGetHeroes_shouldThrowError_whenAPIClientFails() async {
        // Given
        mockAPIClient.shouldThrowError = true

        // When & Then
        do {
            _ = try await dataSource.getHeroes(offset: 0)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

