//
//  UIStackView+ArrangedSubviews.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import UIKit

extension UIStackView {
    func dm_addArrangedSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addArrangedSubview(subview)
        }
    }
}
