//
//  MarvelRepositoryTests.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import XCTest
@testable import WallaMarvel

final class MarvelRepositoryTests: XCTestCase {
    
    var mockDataSource: MockMarvelDataSource!
    var repository: MarvelRepository!

    override func setUp() {
        super.setUp()
        mockDataSource = MockMarvelDataSource()
        repository = MarvelRepository(dataSource: mockDataSource)
    }

    override func tearDown() {
        mockDataSource = nil
        repository = nil
        super.tearDown()
    }

    func testGetHeroes_shouldReturnMappedHeroes_whenDataSourceSucceeds() async throws {
        mockDataSource.shouldThrowError = false
        
        let heroes = try await repository.getHeroes(offset: 0)

        XCTAssertEqual(heroes.count, 2)
        XCTAssertEqual(heroes.first?.name, "Iron Man")
    }

    func testGetHeroes_shouldThrowError_whenDataSourceFails() async {
        mockDataSource.shouldThrowError = true

        do {
            _ = try await repository.getHeroes(offset: 0)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testGetHeroData_shouldReturnMappedHero_whenDataSourceSucceeds() async throws {
        mockDataSource.shouldThrowError = false

        let hero = try await repository.getHeroData(heroId: 1)

        XCTAssertEqual(hero.id, 1)
        XCTAssertEqual(hero.name, "Captain America")
    }

    func testGetHeroData_shouldThrowError_whenDataSourceFails() async {
        mockDataSource.shouldThrowError = true

        do {
            _ = try await repository.getHeroData(heroId: 1)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testGetHeroComics_shouldReturnMappedComics_whenDataSourceSucceeds() async throws {
        mockDataSource.shouldThrowError = false

        let comics = try await repository.getHeroComics(heroId: 1, offset: 0)

        XCTAssertEqual(comics.count, 2)
        XCTAssertEqual(comics.first?.title, "Iron Man #1")
    }

    func testGetHeroComics_shouldThrowError_whenDataSourceFails() async {
        mockDataSource.shouldThrowError = true

        do {
            _ = try await repository.getHeroComics(heroId: 1, offset: 0)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

