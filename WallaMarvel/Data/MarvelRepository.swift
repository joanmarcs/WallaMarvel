import Foundation

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }
    
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void) {
        dataSource.getHeroes(completionBlock: completionBlock)
    }
}
