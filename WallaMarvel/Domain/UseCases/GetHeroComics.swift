//
//  GetHeroComics.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

protocol GetHeroComicsUseCaseProtocol {
    func execute(heroId: Int, offset: Int, completionBlock: @escaping ([Comic]) -> Void)
}

final class GetHeroComics: GetHeroComicsUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    public init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(heroId: Int, offset: Int, completionBlock: @escaping ([Comic]) -> Void) {
        repository.getHeroComics(heroId: heroId, offset: offset, completionBlock: completionBlock)
    }
}
