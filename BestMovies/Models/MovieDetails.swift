//
//  MovieDetails.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

struct MovieDetails: Decodable {
    let title: String
    let overview: String
    let backdropPath: String
    let tagline: String?

    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case backdropPath = "backdrop_path"
        case tagline
    }
}

extension MovieDetails {
    static func details(for movie: Movie) -> Request<MovieDetails> {
        return Request(method: .get, path: "/movie/\(movie.id)")
    }
}
