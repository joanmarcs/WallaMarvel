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

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    private let navigator: ListHeroesNavigatorProtocol
    private var fetchTask: Task<Void, Never>?
    
    private var offset = 0
    private var isLoading = false
    private var allHeroesLoaded = false
    private var heroes: [Hero] = []
    
    public init(getHeroesUseCase: GetHeroesUseCaseProtocol, navigator: ListHeroesNavigatorProtocol) {
        self.getHeroesUseCase = getHeroesUseCase
        self.navigator = navigator

    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() {
        guard !isLoading, !allHeroesLoaded else { return }
        
        fetchTask?.cancel()
        isLoading = true
        
        fetchTask = Task {
            do {
                let newHeroes = try await getHeroesUseCase.execute(offset: offset)
                await MainActor.run {
                    if newHeroes.isEmpty {
                        self.allHeroesLoaded = true
                    } else {
                        self.heroes.append(contentsOf: newHeroes)
                        self.offset += HeroesConstants.limit
                        self.ui?.update(heroes: newHeroes)
                    }
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.ui?.showError(message: "Failed to load heroes.")
                    self.isLoading = false
                }
            }
        }
    }
    
    func didSelectHero(_ hero: Hero) {
        navigator.navigateToHeroDetail(heroId: hero.id)
    }

    public func cancelFetch() {
        fetchTask?.cancel()
    }
}

