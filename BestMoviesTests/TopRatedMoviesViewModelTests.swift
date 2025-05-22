//
//  TopRatedMoviesViewModelTests.swift
//  BestMoviesTests
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

@testable import BestMovies
import XCTest

final class TopRatedMoviesViewModelTests: XCTestCase {
    private var sut: TopRatedMoviesViewModel!
    private var mockUseCase: MockFetchTopRatedMoviesUseCase!

    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchTopRatedMoviesUseCase()
        sut = TopRatedMoviesViewModel(fetchUseCase: mockUseCase)
    }

    override func tearDown() {
        sut = nil
        mockUseCase = nil
        super.tearDown()
    }

    func test_fetchTopRated_success_shouldUpdateMovies() {
        // Given
        let expectation = expectation(description: "Movies updated")
        sut.onMoviesUpdated = {
            expectation.fulfill()
        }

        mockUseCase.result = .success([
            MovieEntity(id: 1, title: "Dune", overview: "Epic sci-fi", posterPath: nil, rating: 8.5, genreNames: "Sci-Fi"),
        ])

        // When
        sut.fetchTopRated()

        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(sut.movies.count, 1)
        XCTAssertEqual(sut.movies.first?.title, "Dune")
    }

    func test_fetchTopRated_failure_shouldCallOnError() {
        // Given
        let expectation = expectation(description: "Error returned")
        sut.onError = { error in
            XCTAssertEqual(error, .network)
            expectation.fulfill()
        }

        mockUseCase.result = .failure(.network)

        // When
        sut.fetchTopRated()

        // Then
        wait(for: [expectation], timeout: 1)
    }

    func test_filter_shouldFilterResults() {
        // Given
        let movies = [
            MovieEntity(id: 1, title: "Dune", overview: "", posterPath: nil, rating: 8, genreNames: ""),
            MovieEntity(id: 2, title: "Avatar", overview: "", posterPath: nil, rating: 7, genreNames: ""),
        ]
        sut.setMoviesForTest(movies)
        sut.filter(with: "dune")

        // Then
        XCTAssertEqual(sut.filteredMovies.count, 1)
        XCTAssertEqual(sut.filteredMovies.first?.title, "Dune")
    }
}
