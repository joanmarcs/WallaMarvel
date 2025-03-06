//
//  MarvelRepositoryProtocol.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

protocol MarvelRepositoryProtocol {
    func getHeroes(offset: Int, completionBlock: @escaping ([Hero]) -> Void)
    func getHeroData(heroId: Int, completionBlock: @escaping (Hero) -> Void)
    func getHeroComics(heroId: Int, offset: Int, completionBlock: @escaping ([Comic]) -> Void)
}
