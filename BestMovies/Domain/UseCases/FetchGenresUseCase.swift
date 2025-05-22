//
//  FetchGenresUseCase.swift
//  BestMovies
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import Foundation

protocol FetchGenresUseCaseProtocol {
    func execute(completion: @escaping (Result<[GenreEntity], AppError>) -> Void)
}

final class FetchGenresUseCase: FetchGenresUseCaseProtocol {
    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[GenreEntity], AppError>) -> Void) {
        repository.getGenres(completion: completion)
    }
}
