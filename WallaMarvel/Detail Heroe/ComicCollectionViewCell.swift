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
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let comicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        stackView.addArrangedSubview(comicImageView)
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            comicImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            comicImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),

            titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.9)
        ])
    }

    func configure(model: Comic) {
        titleLabel.text = model.title
        comicImageView.kf.setImage(with: URL(string: model.thumbnail.url)!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        comicImageView.image = nil
        titleLabel.text = nil
    }
}
