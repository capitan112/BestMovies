//
//  MovieCell.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import UIKit

final class MovieCell: UITableViewCell {
    static let reuseID = "MovieCell"
    let columnSpacing: CGFloat = 16
    let posterSize = CGSize(width: 92, height: 134)

    let coverImage = UIImageView()
    let tagView = TagView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    let textStackView = UIStackView()
    let imageStackView = UIStackView()
    let containerStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping

        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping

        coverImage.contentMode = .scaleAspectFit
        coverImage.layer.cornerRadius = 8
        coverImage.layer.masksToBounds = true

        textStackView.spacing = 4
        textStackView.alignment = .leading
        textStackView.axis = .vertical

        imageStackView.spacing = 10
        imageStackView.alignment = .leading
        imageStackView.axis = .vertical

        containerStackView.spacing = columnSpacing
        containerStackView.alignment = .top
        containerStackView.translatesAutoresizingMaskIntoConstraints = false

        setupViewsHierarchy()
        setupConstraints()
    }

    func setupViewsHierarchy() {
        contentView.addSubview(containerStackView)
        imageStackView.dm_addArrangedSubviews(coverImage, tagView)
        textStackView.dm_addArrangedSubviews(titleLabel, descriptionLabel)
        containerStackView.dm_addArrangedSubviews(imageStackView, textStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),

            coverImage.widthAnchor.constraint(equalToConstant: posterSize.width),
            coverImage.heightAnchor.constraint(equalToConstant: posterSize.height),
        ])
    }

    func configure(with movie: MovieEntity) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        tagView.configure(.rating(value: movie.rating))

        if let posterPath = movie.posterPath {
            coverImage.dm_setImage(posterPath: posterPath)
        } else {
            coverImage.image = nil
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
