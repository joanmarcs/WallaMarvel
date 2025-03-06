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

actor HeroDetailState {
    private var comics: [Comic] = []
    private var isLoading = false
    private var allComicsLoaded = false
    private var offset = 0

    func getComics() -> [Comic] { comics }

    func addComics(_ newComics: [Comic]) {
        comics.append(contentsOf: newComics)
        offset += HeroesConstants.limit
    }

    func isCurrentlyLoading() -> Bool { isLoading }
    func setLoading(_ loading: Bool) { isLoading = loading }
    func setAllComicsLoaded() { allComicsLoaded = true }
    func hasLoadedAllComics() -> Bool { allComicsLoaded }
    func getOffset() -> Int { offset }
}

final class HeroDetailPresenter: HeroDetailPresenterProtocol {
    var ui: HeroDetailUI?
    private let getHeroDataUseCase: GetHeroDataUseCaseProtocol
    private let getHeroComicsUseCase: GetHeroComicsUseCaseProtocol
    private let heroId: Int
    
    private let state = HeroDetailState()
    
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
        fetchComicsTask?.cancel()
        
        fetchComicsTask = Task {
            guard !(await state.isCurrentlyLoading()), !(await state.hasLoadedAllComics()) else { return }
            await state.setLoading(true)
            do {
                let newComics = try await getHeroComicsUseCase.execute(heroId: heroId, offset: await state.getOffset())

                if Task.isCancelled { return }
                
                if newComics.isEmpty {
                    await state.setAllComicsLoaded()
                } else {
                    await state.addComics(newComics)
                }
                
                await updateUI {
                    self.ui?.updateComics(comics: newComics)
                }
            } catch {
                if Task.isCancelled { return }
                
                await updateUI {
                    self.ui?.showError(message: "Failed to load hero comics.")
                }
            }
            await state.setLoading(false)
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
