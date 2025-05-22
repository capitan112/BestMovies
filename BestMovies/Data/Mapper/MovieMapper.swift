//
//  MovieMapper.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

enum MovieMapper {
    static func map(_ movie: Movie) -> MovieEntity {
        MovieEntity(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            posterPath: movie.posterPath,
            rating: movie.voteAverage,
            genreNames: movie.getGenresString()
        )
    }

    static func map(_ movies: [Movie]) -> [MovieEntity] {
        movies.map { map($0) }
    }

    static func mapDetails(_ details: MovieDetails) -> MovieDetailsEntity {
        MovieDetailsEntity(
            title: details.title,
            overview: details.overview,
            backdropPath: details.backdropPath,
            tagline: details.tagline
        )
    }

    static func map(_ genres: [Genre]) -> [GenreEntity] {
        genres.map { GenreEntity(id: $0.id, name: $0.name) }
    }
}
