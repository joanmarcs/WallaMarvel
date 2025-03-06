//
//  HeroComicsAdapter.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
import UIKit

final class HeroComicsAdapter: NSObject, UICollectionViewDataSource {
    private var comics: [Comic] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private let collectionView: UICollectionView

    init(collectionView: UICollectionView, comics: [Comic] = []) {
        self.collectionView = collectionView
        self.comics = comics
        super.init()
        self.collectionView.dataSource = self
    }

    func updateComics(_ newComics: [Comic]) {
        self.comics = newComics
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicCell", for: indexPath) as! ComicCell
        cell.configure(model: comics[indexPath.row])
        return cell
    }
}
