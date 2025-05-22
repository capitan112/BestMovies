//
//  MovieRepository.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

protocol MovieRepositoryProtocol {
    func getTopRated(completion: @escaping (Result<[MovieEntity], AppError>) -> Void)
    func getSimilar(to movie: MovieEntity, completion: @escaping (Result<[MovieEntity], AppError>) -> Void)
    func getDetails(for movie: MovieEntity, completion: @escaping (Result<MovieDetailsEntity, AppError>) -> Void)
    func getGenres(completion: @escaping (Result<[GenreEntity], AppError>) -> Void)
}

final class MovieRepository: MovieRepositoryProtocol {
    private let service: MovieServiceProtocol

    init(service: MovieServiceProtocol) {
        self.service = service
    }

    func getTopRated(completion: @escaping (Result<[MovieEntity], AppError>) -> Void) {
        service.fetchTopRated { result in
            completion(result.map { MovieMapper.map($0) }.mapError { $0.toAppError() })
        }
    }

    func getSimilar(to movie: MovieEntity, completion: @escaping (Result<[MovieEntity], AppError>) -> Void) {
        let movieDTO = Movie(id: movie.id, title: movie.title, overview: movie.overview, posterPath: movie.posterPath, voteAverage: movie.rating, genreIds: [])
        service.fetchSimilar(for: movieDTO) { result in
            completion(result.map { MovieMapper.map($0) }.mapError { $0.toAppError() })
        }
    }

    func getDetails(for movie: MovieEntity, completion: @escaping (Result<MovieDetailsEntity, AppError>) -> Void) {
        let movieDTO = Movie(id: movie.id, title: movie.title, overview: movie.overview, posterPath: movie.posterPath, voteAverage: movie.rating, genreIds: [])
        service.fetchDetails(for: movieDTO) { result in
            completion(result.map { MovieMapper.mapDetails($0) }.mapError { $0.toAppError() })
        }
    }

    func getGenres(completion: @escaping (Result<[GenreEntity], AppError>) -> Void) {
        service.fetchGenres { result in
            completion(result.map { MovieMapper.map($0) }.mapError { $0.toAppError() })
        }
    }
}
