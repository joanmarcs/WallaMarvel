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
    
    public func getHeroData(heroId: Int, completionBlock: @escaping (Hero) -> Void) {
        dataSource.getHeroData(heroId: heroId) { characterDataContainer in
            let hero = characterDataContainer.characters.first!.toDomain()
            completionBlock(hero)
        }
    }
    
    public func getHeroComics(heroId: Int, offset: Int, completionBlock: @escaping ([Comic]) -> Void) {
        dataSource.getHeroComics(heroId: heroId, offset: offset) { characterComicsDataContainer in
            let comics = characterComicsDataContainer.comics.map { $0.toDomain() }
            completionBlock(comics)
        }
    }
}
