//
//  MarvelDataSourceTests.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import XCTest
@testable import WallaMarvel

final class MarvelDataSourceTests: XCTestCase {
    
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
        mockAPIClient.shouldThrowError = false

        let result = try await dataSource.getHeroes(offset: 0)

        XCTAssertEqual(result.characters.count, 2)
    }

    func testGetHeroes_shouldThrowError_whenAPIClientFails() async {
        mockAPIClient.shouldThrowError = true

        do {
            _ = try await dataSource.getHeroes(offset: 0)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

