//
//  FetchMovieDetailsUseCase.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

protocol FetchMovieDetailsUseCaseProtocol {
    func execute(movie: MovieEntity, completion: @escaping (Result<MovieDetailsEntity, AppError>) -> Void)
}

final class FetchMovieDetailsUseCase: FetchMovieDetailsUseCaseProtocol {
    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func execute(movie: MovieEntity, completion: @escaping (Result<MovieDetailsEntity, AppError>) -> Void) {
        repository.getDetails(for: movie, completion: completion)
    }
}
