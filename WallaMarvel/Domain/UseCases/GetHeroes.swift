import Foundation

protocol GetHeroesUseCaseProtocol {
    func execute(offset: Int) async throws -> [Hero]
}

final class GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    init(repository: MarvelRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(offset: Int) async throws -> [Hero]  {
        return try await repository.getHeroes(offset: offset)
    }
}
