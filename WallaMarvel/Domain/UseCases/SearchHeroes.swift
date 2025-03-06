//
//  SearchHeroes.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

protocol SearchHeroesUseCaseProtocol {
    func execute(startsWith: String) async throws -> [Hero]
}

final class SearchHeroes: SearchHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(startsWith: String) async throws -> [Hero]  {
        return try await repository.searchHeroes(startsWith: startsWith)
    }
}
