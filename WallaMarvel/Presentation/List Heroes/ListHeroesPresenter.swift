import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
    func didSelectHero(_ hero: Hero)
    func cancelFetch()
    func updateSearchText(_ searchText: String)
    func searchHeroes(searchText: String)
    func cancelSearch()
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [Hero])
    func removeHeroes()
    func showError(message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
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
    func setOffset(toValue: Int) { offset = toValue}
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    private let searchHeroesUseCase: SearchHeroesUseCaseProtocol
    private let navigator: ListHeroesNavigatorProtocol
    private var fetchTask: Task<Void, Never>?
    
    private let state = ListHeroesState()
    
    private var currentSearchText: String = ""
    
    public init(getHeroesUseCase: GetHeroesUseCaseProtocol,
                searchHeroesUseCase: SearchHeroesUseCaseProtocol, navigator: ListHeroesNavigatorProtocol) {
        self.getHeroesUseCase = getHeroesUseCase
        self.searchHeroesUseCase = searchHeroesUseCase
        self.navigator = navigator

    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // Updates the search text and decides whether to fetch new data
    func updateSearchText(_ searchText: String) {
        if searchText.isEmpty {
            self.ui?.hideLoadingIndicator()
        } else if searchText != currentSearchText {
            currentSearchText = searchText
            self.ui?.showLoadingIndicator()
            searchHeroes(searchText: searchText)
        }
    }
    
    // Cancels search and reloads the full list of heroes
    func cancelSearch() {
        self.ui?.removeHeroes()
        getHeroes()
    }
    
    // MARK: UseCases
    
    // Fetches the list of heroes with pagination
    func getHeroes() {
        currentSearchText = ""
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
    
    // Searches for heroes by name using the API.
    func searchHeroes(searchText: String) {
        fetchTask?.cancel()

        self.ui?.removeHeroes()
        
        fetchTask = Task {
            
            await state.setOffset(toValue: 0)
            
            do {
                let searchedHeroes = try await searchHeroesUseCase.execute(startsWith: searchText)
                if Task.isCancelled { return }
                
                await MainActor.run {
                    self.ui?.update(heroes: searchedHeroes)
                    self.ui?.hideLoadingIndicator()
                }
            } catch {
                if Task.isCancelled { return }
                
                await MainActor.run {
                    self.ui?.showError(message: "Failed to search heroes.")
                    self.ui?.hideLoadingIndicator() 
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

