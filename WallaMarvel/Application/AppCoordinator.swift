//
//  AppCoordinator.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
import UIKit

final class AppCoordinator: ListHeroesNavigatorProtocol  {

    private let window: UIWindow
    private let navigationController: UINavigationController


    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        
        //Dependency injection
        let repository = MarvelRepository(dataSource: MarvelDataSource())
        let getHeroesUseCase = GetHeroes(repository: repository)
        let searchHeroesUseCase = SearchHeroes(repository: repository)
        let presenter = ListHeroesPresenter(getHeroesUseCase: getHeroesUseCase, searchHeroesUseCase: searchHeroesUseCase, navigator: self)
        let listHeroesViewController = ListHeroesViewController()
        listHeroesViewController.presenter = presenter

        //Iniatial flow
        navigationController.viewControllers = [listHeroesViewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func navigateToHeroDetail(heroId: Int) {
        let repository = MarvelRepository(dataSource: MarvelDataSource())
        let getHeroDataUseCase = GetHeroDataUseCase(repository: repository)
        let getHeroComicsUseCase = GetHeroComics(repository: repository)

        let presenter = HeroDetailPresenter(heroId: heroId, getHeroDataUseCase: getHeroDataUseCase, getHeroComicsUseCase: getHeroComicsUseCase)
        let heroDetailViewController = HeroDetailViewController()
        heroDetailViewController.presenter = presenter

        navigationController.pushViewController(heroDetailViewController, animated: true)
    }

}

