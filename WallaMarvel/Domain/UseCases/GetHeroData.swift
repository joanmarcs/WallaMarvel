//
//  GetHeroData.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

protocol GetHeroDataUseCaseProtocol {
    func execute(heroId: Int) async throws -> Hero
}

final class GetHeroDataUseCase: GetHeroDataUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol

    public init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(heroId: Int) async throws -> Hero {
        return try await repository.getHeroData(heroId: heroId)
    }
}
