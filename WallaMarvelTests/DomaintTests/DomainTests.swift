//
//  DomainTests.swift
//  WallaMarvelTests
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import XCTest
@testable import WallaMarvel

final class DomainTests: XCTestCase {

    var mockRepository: MockMarvelRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockMarvelRepository()
    }

    override func tearDown() {
        mockRepository = nil
        super.tearDown()
    }


    func testGetHeroes_shouldReturnHeroes_whenRepositorySucceeds() async throws {
        let useCase = GetHeroes(repository: mockRepository)
        
        let heroes = try await useCase.execute(offset: 0)
        
        XCTAssertEqual(heroes.count, 2)
        XCTAssertEqual(heroes.first?.name, "Iron Man")
    }

    func testGetHeroes_shouldThrowError_whenRepositoryFails() async {
        mockRepository.shouldThrowError = true
        let useCase = GetHeroes(repository: mockRepository)
        
        do {
            _ = try await useCase.execute(offset: 0)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testGetHeroData_shouldReturnHero_whenRepositorySucceeds() async throws {
        let useCase = GetHeroDataUseCase(repository: mockRepository)
        
        let hero = try await useCase.execute(heroId: 1)
        
        XCTAssertEqual(hero.id, 1)
        XCTAssertEqual(hero.name, "Captain America")
    }

    func testGetHeroData_shouldThrowError_whenRepositoryFails() async {
        mockRepository.shouldThrowError = true
        let useCase = GetHeroDataUseCase(repository: mockRepository)
        
        do {
            _ = try await useCase.execute(heroId: 1)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testGetHeroComics_shouldReturnComics_whenRepositorySucceeds() async throws {
        let useCase = GetHeroComics(repository: mockRepository)
        
        let comics = try await useCase.execute(heroId: 1, offset: 0)
        
        XCTAssertEqual(comics.count, 2)
        XCTAssertEqual(comics.first?.title, "Iron Man #1")
    }

    func testGetHeroComics_shouldThrowError_whenRepositoryFails() async {
        mockRepository.shouldThrowError = true
        let useCase = GetHeroComics(repository: mockRepository)
        
        do {
            _ = try await useCase.execute(heroId: 1, offset: 0)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
