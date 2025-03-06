import Foundation

protocol GetHeroesUseCaseProtocol {
    func execute(offset: Int, completionBlock: @escaping ([Hero]) -> Void)
}

final class GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(offset: Int, completionBlock: @escaping ([Hero]) -> Void) {
        repository.getHeroes(offset: offset, completionBlock: completionBlock)
    }
}
