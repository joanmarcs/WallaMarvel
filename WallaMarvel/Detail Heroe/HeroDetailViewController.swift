//
//  HeroDetailViewController.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
import UIKit
import Kingfisher

final class HeroDetailViewController: UIViewController {
    var mainView: HeroDetailView { return view as! HeroDetailView }
    var presenter: HeroDetailPresenterProtocol?
    
    override func loadView() {
        view = HeroDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchHeroData()
        presenter?.ui = self
    }
}

extension HeroDetailViewController: HeroDetailUI {
    func updateHeroDetail(hero: Hero) {
        self.title = hero.name
        mainView.descriptionLabel.text = hero.description
        let imageURL = hero.thumbnail.url
        mainView.imageView.kf.setImage(with: URL(string: hero.thumbnail.url))
    }
}
