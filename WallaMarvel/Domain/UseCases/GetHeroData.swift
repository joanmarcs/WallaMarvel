//
//  GetHeroData.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

protocol GetHeroDataUseCaseProtocol {
    func execute(heroId: Int, completion: @escaping (Hero) -> Void)
}

final class GetHeroDataUseCase: GetHeroDataUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol

    public init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(heroId: Int, completion: @escaping (Hero) -> Void) {
        repository.getHeroData(heroId: heroId, completionBlock: completion)
    }
}
