//
//  MarvelRepositoryProtocol.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation

protocol MarvelRepositoryProtocol {
    func getHeroes(completionBlock: @escaping ([Hero]) -> Void)
}
