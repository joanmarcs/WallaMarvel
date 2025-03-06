import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(offset: Int) async throws -> CharacterDataContainer
    func getHeroData(heroId: Int) async throws -> CharacterDataContainer
    func getHeroComics(heroId: Int, offset: Int) async throws -> CharacterComicsDataContainer
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getHeroes(offset: Int) async throws -> CharacterDataContainer {
        return try await apiClient.getHeroes(offset: offset)
    }
    
    func getHeroData(heroId: Int) async throws -> CharacterDataContainer {
        return try await apiClient.getHeroData(heroId: heroId)
    }
    
    func getHeroComics(heroId: Int, offset: Int) async throws -> CharacterComicsDataContainer {
        return try await apiClient.getHeroComics(heroId: heroId, offset: offset)
    }
}
