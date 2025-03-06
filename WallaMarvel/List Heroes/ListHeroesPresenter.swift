import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getHeroes()
}

protocol ListHeroesUI: AnyObject {
    func update(heroes: [Hero])
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
    var ui: ListHeroesUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    private var offset = 0
    private var isLoading = false
    private var allHeroesLoaded = false
    private var heroes: [Hero] = []
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol) {
        self.getHeroesUseCase = getHeroesUseCase
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
}

