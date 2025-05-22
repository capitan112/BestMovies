//
//  TagView.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation
import UIKit

final class TagView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ style: Style) {
        backgroundColor = style.backgroundColor
        iconView.tintColor = style.tintColor
        iconView.image = style.icon
        iconView.isHidden = style.icon == nil
        textLabel.textColor = style.tintColor
        textLabel.text = style.text
    }

    private let stackView: UIStackView = .init()
    private let iconView: UIImageView = .init()
    private let textLabel: UILabel = .init()

    private func commonInit() {
        layoutMargins = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)

        layer.cornerRadius = 4

        iconView.contentMode = .scaleAspectFit

        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.baselineAdjustment = .alignCenters

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.dm_addArrangedSubviews(iconView, textLabel)

        addSubview(stackView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension TagView {
    enum Style {
        case rating(value: Double)

        fileprivate var backgroundColor: UIColor {
            switch self {
            case .rating:
                return UIColor.black
            }
        }

        fileprivate var tintColor: UIColor {
            switch self {
            case .rating:
                return UIColor.white
            }
        }

        fileprivate var icon: UIImage? {
            switch self {
            case .rating:
                return UIImage(named: "Star")?.withRenderingMode(.alwaysTemplate)
            }
        }

        fileprivate var text: String {
            switch self {
            case let .rating(value):
                return String(format: "%.1f", value)
            }
        }
    }
}
