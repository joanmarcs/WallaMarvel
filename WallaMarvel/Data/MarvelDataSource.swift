import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(offset: Int, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHeroData(heroId: Int, completionBlock: @escaping (CharacterDataContainer) -> Void)
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
}
