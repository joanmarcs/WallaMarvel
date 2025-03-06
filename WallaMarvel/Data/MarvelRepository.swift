import Foundation

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    public func getHeroes(offset: Int) async throws -> [Hero] {
        let characterDataContainer = try await dataSource.getHeroes(offset: offset)
        return characterDataContainer.characters.map { $0.toDomain() }
    }
    
    public func getHeroData(heroId: Int) async throws -> Hero {
        let characterDataContainer = try await dataSource.getHeroData(heroId: heroId)
        guard let hero = characterDataContainer.characters.first else {
            throw APIError.serverError
        }
        return hero.toDomain()
    }
    
    public func getHeroComics(heroId: Int, offset: Int) async throws -> [Comic] {
        let characterComicsDataContainer = try await dataSource.getHeroComics(heroId: heroId, offset: offset)
        return characterComicsDataContainer.comics.map { $0.toDomain() }
    }
    
    func searchHeroes(startsWith: String) async throws -> [Hero] {
        let characterDataContainer = try await dataSource.searchHeroes(startsWith: startsWith)
        return characterDataContainer.characters.map { $0.toDomain() }
    }
}
