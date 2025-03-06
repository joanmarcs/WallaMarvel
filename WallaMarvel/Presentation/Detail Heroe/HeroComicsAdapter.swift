//
//  HeroComicsAdapter.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
import UIKit

final class HeroComicsAdapter: NSObject, UICollectionViewDataSource {
    var comics: [Comic]

    private let collectionView: UICollectionView

    init(collectionView: UICollectionView, comics: [Comic] = []) {
        self.collectionView = collectionView
        self.comics = comics
        super.init()
        self.collectionView.dataSource = self
    }

    func updateComics(_ newComics: [Comic]) {
        guard !newComics.isEmpty else { return }

        let startIndex = comics.count
        let endIndex = startIndex + newComics.count - 1
        let indexPaths = (startIndex...endIndex).map { IndexPath(item: $0, section: 0) }

        self.comics.append(contentsOf: newComics)

        DispatchQueue.main.async {
            if startIndex == 0 {
                self.collectionView.reloadData()
            } else {
                self.collectionView.performBatchUpdates({
                    self.collectionView.insertItems(at: indexPaths)
                }, completion: nil)
            }
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
