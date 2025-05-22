//
//  FetchTopRatedMovies.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

protocol FetchTopRatedMoviesUseCaseProtocol {
    func execute(completion: @escaping (Result<[MovieEntity], AppError>) -> Void)
}

final class FetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCaseProtocol {
    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[MovieEntity], AppError>) -> Void) {
        repository.getTopRated(completion: completion)
    }
}
