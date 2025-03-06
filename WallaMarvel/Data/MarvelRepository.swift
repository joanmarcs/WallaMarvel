import Foundation

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    public func getHeroes(offset: Int, completionBlock: @escaping ([Hero]) -> Void) {
        dataSource.getHeroes(offset: offset) { characterDataContainer in
            let heroes = characterDataContainer.characters.map { $0.toDomain() }
            completionBlock(heroes)
        }
    }
}
