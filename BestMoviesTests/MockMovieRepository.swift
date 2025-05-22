//
//  MockMovieRepository.swift
//  BestMoviesTests
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

@testable import BestMovies

final class MockMovieRepository: MovieRepositoryProtocol {
    var result: Result<[MovieEntity], AppError> = .success([])

    func getTopRated(completion: @escaping (Result<[MovieEntity], AppError>) -> Void) {
        completion(result)
    }

    func getSimilar(to _: MovieEntity, completion _: @escaping (Result<[MovieEntity], AppError>) -> Void) {}
    func getDetails(for _: MovieEntity, completion _: @escaping (Result<MovieDetailsEntity, AppError>) -> Void) {}
    func getGenres(completion _: @escaping (Result<[GenreEntity], AppError>) -> Void) {}
}
