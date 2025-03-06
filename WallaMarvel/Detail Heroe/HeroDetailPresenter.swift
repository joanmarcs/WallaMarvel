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
    func showError(message: String)
}

protocol HeroDetailPresenterProtocol: AnyObject {
    var ui: HeroDetailUI? { get set }
    func fetchHeroData()
    func getHeroComics()
    func cancelFetch()
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
    
    private var fetchHeroTask: Task<Void, Never>?
    private var fetchComicsTask: Task<Void, Never>?
    
    init(heroId: Int, getHeroDataUseCase: GetHeroDataUseCaseProtocol, getHeroComicsUseCase: GetHeroComicsUseCaseProtocol) {
        self.heroId = heroId
        self.getHeroDataUseCase = getHeroDataUseCase
        self.getHeroComicsUseCase = getHeroComicsUseCase
    }
    
    public func fetchHeroData() {
        fetchHeroTask?.cancel()
        
        fetchHeroTask = Task {
            do {
                let hero = try await getHeroDataUseCase.execute(heroId: heroId)
                if Task.isCancelled { return }
                await updateUI {
                    self.ui?.updateHeroDetail(hero: hero) }
            } catch {
                if Task.isCancelled { return }
                await updateUI {
                    self.ui?.showError(message: "Failed to load hero details.") }
            }
        }
    }
    
    public func getHeroComics() {
        guard !isLoading, !allComicsLoaded else { return }
        
        fetchComicsTask?.cancel()
        isLoading = true
        
        fetchComicsTask = Task {
            do {
                let newComics = try await getHeroComicsUseCase.execute(heroId: heroId, offset: offset)
                
                if Task.isCancelled { return }
                
                if newComics.isEmpty {
                    allComicsLoaded = true
                } else {
                    comics.append(contentsOf: newComics)
                    offset += HeroesConstants.limit
                }
                
                await updateUI {
                    self.ui?.updateComics(comics: newComics) }
                isLoading = false
            } catch {
                if Task.isCancelled { return }
                
                await updateUI {
                    self.ui?.showError(message: "Failed to load hero comics.") }
                isLoading = false
            }
        }
    }
    
    public func cancelFetch() {
        fetchHeroTask?.cancel()
        fetchComicsTask?.cancel()
    }
    
    private func updateUI(_ action: @escaping () -> Void) async {
        await MainActor.run {
            action()
        }
    }
}
