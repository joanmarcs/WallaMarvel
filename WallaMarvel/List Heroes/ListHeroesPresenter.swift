import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
    func didSelectHero(_ hero: Hero)
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [Hero])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    private let navigator: ListHeroesNavigatorProtocol
    
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
        isLoading = true
        
        getHeroesUseCase.execute(offset: offset) { [weak self] newHeroes in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if newHeroes.isEmpty {
                    self.allHeroesLoaded = true
                } else {
                    self.heroes.append(contentsOf: newHeroes)
                    self.offset += HeroesConstants.limit
                    self.ui?.update(heroes: self.heroes)
                }
                self.isLoading = false
            }
        }
    }
    
    func didSelectHero(_ hero: Hero) {
        navigator.navigateToHeroDetail(heroId: hero.id)
    }

}

