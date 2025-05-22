//
//  MockMovieService.swift
//  BestMoviesTests
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

@testable import BestMovies

final class MockMovieService: MovieServiceProtocol {
    var mockMovies: [Movie] = []
    var shouldReturnError = false
    var mockMovieDetails: MovieDetails?
    var mockGenres: [Genre] = []

    func fetchTopRated(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.networkError))
        } else {
            completion(.success(mockMovies))
        }
    }

    func fetchDetails(for _: Movie, completion: @escaping (Result<MovieDetails, APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.networkError))
        } else if let details = mockMovieDetails {
            completion(.success(details))
        } else {
            completion(.failure(.networkError))
        }
    }

    func fetchGenres(completion: @escaping (Result<[Genre], APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.networkError))
        } else {
            completion(.success(mockGenres))
        }
    }

    func fetchSimilar(for _: Movie, completion _: @escaping (Result<[Movie], APIError>) -> Void) {}
}
