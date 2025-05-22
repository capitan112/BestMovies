//
//  FetchTopRatedMoviesUseCaseTest.swift
//  BestMoviesTests
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

@testable import BestMovies
import XCTest

final class FetchTopRatedMoviesUseCaseTests: XCTestCase {
    private var sut: FetchTopRatedMoviesUseCase!
    private var mockRepository: MockMovieRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        sut = FetchTopRatedMoviesUseCase(repository: mockRepository)
    }

    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }

    func test_execute_success() {
        // Given
        let expectation = expectation(description: "Success")
        mockRepository.result = .success([
            MovieEntity(id: 1, title: "Dune", overview: "Sci-fi", posterPath: nil, rating: 9, genreNames: "Sci-Fi"),
        ])

        // When
        sut.execute { result in
            // Then
            if case let .success(movies) = result {
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies.first?.title, "Dune")
                expectation.fulfill()
            } else {
                XCTFail("Expected success, got failure")
            }
        }

        wait(for: [expectation], timeout: 1)
    }

    func test_execute_failure() {
        // Given
        let expectation = expectation(description: "Failure")
        mockRepository.result = .failure(.decoding)

        // When
        sut.execute { result in
            // Then
            if case let .failure(error) = result {
                XCTAssertEqual(error, .decoding)
                expectation.fulfill()
            } else {
                XCTFail("Expected failure, got success")
            }
        }

        wait(for: [expectation], timeout: 1)
    }
}
