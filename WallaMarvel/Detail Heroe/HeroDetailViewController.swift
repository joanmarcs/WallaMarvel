//
//  HeroDetailViewController.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
import UIKit

public final class HeroDetailViewController: UIViewController {
    public var mainView: HeroDetailView { return view as! HeroDetailView }

    public override func loadView() {
        view = HeroDetailView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
