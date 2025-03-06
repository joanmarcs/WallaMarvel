//
//  MarvelRepositoryProtocol.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

protocol MarvelRepositoryProtocol {
    func getHeroes(offset: Int) async throws -> [Hero]
    func getHeroData(heroId: Int) async throws -> Hero
    func getHeroComics(heroId: Int, offset: Int) async throws -> [Comic]
    func searchHeroes(startsWith: String) async throws -> [Hero]
}
