//
//  MockFetchTopRatedMoviesUseCase.swift
//  BestMoviesTests
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

@testable import BestMovies
import Foundation

final class MockFetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCaseProtocol {
    var result: Result<[MovieEntity], AppError> = .success([])

    func execute(completion: @escaping (Result<[MovieEntity], AppError>) -> Void) {
        completion(result)
    }
}
