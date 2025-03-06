//
//  HeroDetailPresenter.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

protocol HeroDetailUI: AnyObject {
    func updateHeroDetail(hero: Hero)
    func updateComics(comics: [Comic])
}

protocol HeroDetailPresenterProtocol: AnyObject {
    var ui: HeroDetailUI? { get set }
    func fetchHeroData()
    func getHeroComics()
}

final class HeroDetailPresenter: HeroDetailPresenterProtocol {
    var ui: HeroDetailUI?
    private let getHeroDataUseCase: GetHeroDataUseCaseProtocol
    private let getHeroComicsUseCase: GetHeroComicsUseCaseProtocol
    
    private let heroId: Int
    
    private var offset = 0
    private var isLoading = false
    private var allComicsLoaded = false
    
    private var comics: [Comic] = []

    init(heroId: Int, getHeroDataUseCase: GetHeroDataUseCaseProtocol, getHeroComicsUseCase: GetHeroComicsUseCaseProtocol) {
        self.heroId = heroId
        self.getHeroDataUseCase = getHeroDataUseCase
        self.getHeroComicsUseCase = getHeroComicsUseCase
    }

    public func fetchHeroData() {
        getHeroDataUseCase.execute(heroId: heroId) { [weak self] hero in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.ui?.updateHeroDetail(hero: hero)
            }
        }
    }
    
    public func getHeroComics() {
        guard !isLoading, !allComicsLoaded else { return }
        
        isLoading = true
        
        getHeroComicsUseCase.execute(heroId: heroId, offset: offset) { [weak self] newComics in
                    guard let self = self else { return }

                    DispatchQueue.main.async {
                        if newComics.isEmpty {
                            self.allComicsLoaded = true
                        } else {
                            self.comics.append(contentsOf: newComics)
                            self.offset += HeroesConstants.limit
                            self.ui?.updateComics(comics: self.comics)
                        }
                        self.isLoading = false
                    }
                }
    }
}
