import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHeroData(heroId: Int, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHeroComics(heroId: Int, offset: Int, completionBlock: @escaping (CharacterComicsDataContainer) -> Void)
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        return apiClient.getHeroes(offset: offset, completionBlock: completionBlock)
    }
    
    func getHeroData(heroId: Int, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        return apiClient.getHeroData(heroId: heroId, completionBlock: completionBlock)
    }
    
    func getHeroComics(heroId: Int, offset: Int, completionBlock: @escaping (CharacterComicsDataContainer) -> Void) {
        return apiClient.getHeroComics(heroId: heroId, offset: offset, completionBlock: completionBlock)
    }
}
