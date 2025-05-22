//
//  Movie.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
    }

    func getGenresString() -> String {
        return GenreMapping.convertGenreIdsToString(genreIds)
    }
}

extension Movie {
    static var topRated: Request<Page<Movie>> {
        return Request(method: .get, path: "/movie/top_rated")
    }

    static func similar(for movie: Movie) -> Request<Page<Movie>> {
        return Request(method: .get, path: "/movie/\(movie.id)/similar")
    }
}
