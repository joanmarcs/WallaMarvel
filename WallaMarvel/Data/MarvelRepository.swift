import Foundation

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }
    
    func getHeroes(completionBlock: @escaping ([Hero]) -> Void) {
        dataSource.getHeroes { characterDataContainer in
            let heroes = characterDataContainer.characters.map { $0.toDomain() }
            completionBlock(heroes)
        }
    }
}
