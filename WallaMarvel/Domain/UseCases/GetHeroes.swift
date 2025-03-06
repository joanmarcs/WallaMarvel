import Foundation

protocol GetHeroesUseCaseProtocol {
    func execute(completionBlock: @escaping ([Hero]) -> Void)
}

struct GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    init(repository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.repository = repository
    }
    
    func execute(completionBlock: @escaping ([Hero]) -> Void) {
        repository.getHeroes(completionBlock: completionBlock)
    }
}
