import Foundation

protocol APIClientProtocol {
    func getHeroes(offset: Int) async throws -> CharacterDataContainer
    func getHeroData(heroId: Int) async throws -> CharacterDataContainer
    func getHeroComics(heroId: Int, offset: Int) async throws -> CharacterComicsDataContainer
    func searchHeroes(startsWith: String) async throws -> CharacterDataContainer
}

final class APIClient: APIClientProtocol {

    
    enum Constant {
        static let privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
        static let publicKey = "d575c26d5c746f623518e753921ac847"
    }
    
    init() { }
    
    private func setupAuthParams() -> [String: String] {
            let ts = String(Int(Date().timeIntervalSince1970))
            let hash = "\(ts)\(Constant.privateKey)\(Constant.publicKey)".md5
            return [
                "apikey": Constant.publicKey,
                "ts": ts,
                "hash": hash
            ]
    }
    
    private func fetch<T: Decodable>(endpoint: String, params: [String: String]) async throws -> T {
        var urlComponent = URLComponents(string: endpoint)
        urlComponent?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponent?.url else {
            throw APIError.invalidURL

        }
        
        var urlRequest = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            throw APIError.decodingError(decodingError.localizedDescription)
        } catch {
            throw APIError.networkError(error.localizedDescription)
        }

    }
    
    func getHeroes(offset: Int) async throws -> CharacterDataContainer {
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
        var params = setupAuthParams()
        params["offset"] = "\(offset)"
        params["limit"] = "\(HeroesConstants.limit)"

        return try await fetch(endpoint: endpoint, params: params)
    }

    func getHeroData(heroId: Int) async throws -> CharacterDataContainer {
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters/\(heroId)"
        let params = setupAuthParams()

        return try await fetch(endpoint: endpoint, params: params)
    }

    func getHeroComics(heroId: Int, offset: Int) async throws -> CharacterComicsDataContainer {
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters/\(heroId)/comics"
        var params = setupAuthParams()
        params["offset"] = "\(offset)"
        params["limit"] = "\(HeroesConstants.limit)"

        return try await fetch(endpoint: endpoint, params: params)
    }
    
    func searchHeroes(startsWith: String) async throws -> CharacterDataContainer {
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
        var params = setupAuthParams()
        params["nameStartsWith"] = startsWith

        return try await fetch(endpoint: endpoint, params: params)
    }

}
