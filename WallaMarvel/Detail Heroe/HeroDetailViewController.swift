//
//  HeroDetailViewController.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
import UIKit

final class HeroDetailViewController: UIViewController {
    var mainView: HeroDetailView { return view as! HeroDetailView }
    var presenter: HeroDetailPresenterProtocol?

    override func loadView() {
        view = HeroDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchHeroData()
    }
}

extension HeroDetailViewController: HeroDetailUI {
    func updateHeroDetail(hero: Hero) {
        mainView.nameLabel.text = hero.name
        //mainView.descriptionLabel.text = hero.description
//        if let imageURL = hero.thumbnail.url {
//        }
    }
}
