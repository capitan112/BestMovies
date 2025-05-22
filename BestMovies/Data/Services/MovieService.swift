//
//  MovieService.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchTopRated(completion: @escaping (Result<[Movie], APIError>) -> Void)
    func fetchSimilar(for movie: Movie, completion: @escaping (Result<[Movie], APIError>) -> Void)
    func fetchDetails(for movie: Movie, completion: @escaping (Result<MovieDetails, APIError>) -> Void)
    func fetchGenres(completion: @escaping (Result<[Genre], APIError>) -> Void)
}

final class MovieService: MovieServiceProtocol {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchTopRated(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        networkClient.execute(Movie.topRated) { (result: Result<Page<Movie>, APIError>) in
            completion(result.map { $0.results })
        }
    }

    func fetchSimilar(for movie: Movie, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        networkClient.execute(Movie.similar(for: movie)) { (result: Result<Page<Movie>, APIError>) in
            completion(result.map { $0.results })
        }
    }

    func fetchDetails(for movie: Movie, completion: @escaping (Result<MovieDetails, APIError>) -> Void) {
        networkClient.execute(MovieDetails.details(for: movie), completion: completion)
    }

    func fetchGenres(completion: @escaping (Result<[Genre], APIError>) -> Void) {
        networkClient.execute(Genres.genresRequest()) { result in
            completion(result.map { $0.genres })
        }
    }
}
