//
//  ComicCollectionViewCell.swift
//  WallaMarvel
//
//  Created by Joan Marc Sanahuja on 6/3/25.
//

import Foundation
import UIKit
import Kingfisher

final class ComicCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let comicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubviews()
        addContraints()
    }
    
    private func addSubviews() {
        addSubview(comicImageView)
        addSubview(titleLabel)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            comicImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            comicImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            comicImageView.heightAnchor.constraint(equalToConstant: 80),
            comicImageView.widthAnchor.constraint(equalToConstant: 80),
            comicImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            titleLabel.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: comicImageView.topAnchor, constant: 8),
        ])
    }

    func configure(model: Comic) {
        titleLabel.text = model.title
        comicImageView.kf.setImage(with: URL(string: model.thumbnail.url)!)
    }
}
