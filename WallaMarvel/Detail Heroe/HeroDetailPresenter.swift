//
//  HeroDetailPresenter.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

protocol HeroDetailUI: AnyObject {
    func updateHeroDetail(hero: Hero)
}

protocol HeroDetailPresenterProtocol: AnyObject {
    var ui: HeroDetailUI? { get set }
    func fetchHeroData()
}

final class HeroDetailPresenter: HeroDetailPresenterProtocol {
    var ui: HeroDetailUI?
    private let heroId: Int
    private let getHeroDataUseCase: GetHeroDataUseCaseProtocol

    init(heroId: Int, getHeroDataUseCase: GetHeroDataUseCaseProtocol) {
        self.heroId = heroId
        self.getHeroDataUseCase = getHeroDataUseCase
    }

    public func fetchHeroData() {
        getHeroDataUseCase.execute(heroId: heroId) { [weak self] hero in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.ui?.updateHeroDetail(hero: hero)
            }
        }
    }
}
