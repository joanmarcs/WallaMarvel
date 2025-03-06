//
//  AppCoordinator.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        
        //Dependency injection
        let repository = MarvelRepository(dataSource: MarvelDataSource())
        let getHeroesUseCase = GetHeroes(repository: repository)
        let presenter = ListHeroesPresenter(getHeroesUseCase: getHeroesUseCase)
        let listHeroesViewController = ListHeroesViewController()
        listHeroesViewController.presenter = presenter

        //Iniatial flow
        let navigationController = UINavigationController(rootViewController: listHeroesViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

