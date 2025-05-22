//
//  UIImageView+PosterLoading.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import SDWebImage
import UIKit

extension UIImageView {
    func dm_setImage(posterPath: String) {
        let baseURL = "https://image.tmdb.org/t/p/w185/"
        guard let url = URL(string: baseURL + posterPath) else {
            image = UIImage(systemName: "film")
            return
        }
        sd_setImage(with: url, placeholderImage: UIImage(systemName: "film"))
    }

    func dm_setImage(backdropPath: String) {
        let baseURL = "https://image.tmdb.org/t/p/w1280/"
        guard let url = URL(string: baseURL + backdropPath) else {
            image = UIImage(systemName: "photo")
            return
        }
        sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
    }
}
