import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
    func didSelectHero(_ hero: Hero)
    func cancelFetch()
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [Hero])
    func showError(message: String)
}

actor ListHeroesState {
    private var heroes: [Hero] = []
    private var isLoading = false
    private var allHeroesLoaded = false
    private var offset = 0

    func getHeroes() -> [Hero] { heroes }

    func addHeroes(_ newHeroes: [Hero]) {
        heroes.append(contentsOf: newHeroes)
        offset += HeroesConstants.limit
    }

    func isCurrentlyLoading() -> Bool { isLoading }
    func setLoading(_ loading: Bool) { isLoading = loading }
    func setAllHeroesLoaded() { allHeroesLoaded = true }
    func hasLoadedAllHeroes() -> Bool { allHeroesLoaded }
    func getOffset() -> Int { offset }
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    private let navigator: ListHeroesNavigatorProtocol
    private var fetchTask: Task<Void, Never>?
    
    private let state = ListHeroesState()
    
    public init(getHeroesUseCase: GetHeroesUseCaseProtocol, navigator: ListHeroesNavigatorProtocol) {
        self.getHeroesUseCase = getHeroesUseCase
        self.navigator = navigator

    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() {
        fetchTask?.cancel()
        
        fetchTask = Task {
            guard !(await state.isCurrentlyLoading()), !(await state.hasLoadedAllHeroes()) else { return }
            
            await state.setLoading(true)
            
            do {
                let newHeroes = try await getHeroesUseCase.execute(offset: await state.getOffset())
                if Task.isCancelled { return }
                
                if newHeroes.isEmpty {
                    await state.setAllHeroesLoaded()
                } else {
                    await state.addHeroes(newHeroes)
                }
                
                await MainActor.run {
                    self.ui?.update(heroes: newHeroes)
                }
            } catch {
                if Task.isCancelled { return }
                
                await MainActor.run {
                    self.ui?.showError(message: "Failed to load heroes.")
                }
            }
            await state.setLoading(false)
        }
    }
    
    func didSelectHero(_ hero: Hero) {
        navigator.navigateToHeroDetail(heroId: hero.id)
    }

    public func cancelFetch() {
        fetchTask?.cancel()
    }
}

