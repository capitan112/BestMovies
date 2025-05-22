//
//  MovieRepositoryTests.swift
//  BestMoviesTests
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

@testable import BestMovies
import XCTest

final class MovieRepositoryTests: XCTestCase {
    private var sut: MovieRepository!
    private var mockService: MockMovieService!

    override func setUp() {
        super.setUp()
        mockService = MockMovieService()
        sut = MovieRepository(service: mockService)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }

    func test_getTopRated_success_returnsMappedMovies() {
        // Given
        mockService.mockMovies = [
            Movie(id: 1, title: "Dune", overview: "Dreams", posterPath: nil, voteAverage: 9.0, genreIds: []),
        ]

        let expectation = expectation(description: "Got mapped movies")

        // When
        sut.getTopRated { result in
            // Then
            switch result {
            case let .success(movies):
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies.first?.title, "Dune")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }

        wait(for: [expectation], timeout: 1)
    }

    func test_getTopRated_failure_returnsAppError() {
        // Given
        mockService.shouldReturnError = true

        let expectation = expectation(description: "Got error")

        // When
        sut.getTopRated { result in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case let .failure(error):
                XCTAssertEqual(error, .network)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1)
    }

    func test_getDetails_success_returnsMappedMovieDetailsEntity() {
        // Given
        let movieEntity = MovieEntity(
            id: 1,
            title: "Dune",
            overview: "Dreams",
            posterPath: nil,
            rating: 9.0,
            genreNames: ""
        )

        mockService.mockMovieDetails = MovieDetails(
            title: "Dune",
            overview: "Sci-Fi Epic",
            backdropPath: "/image.jpg",
            tagline: "Fear is the mind killer"
        )

        let expectation = expectation(description: "Mapped movie details")

        // When
        sut.getDetails(for: movieEntity) { result in
            switch result {
            case let .success(details):
                XCTAssertEqual(details.title, "Dune")
                XCTAssertEqual(details.overview, "Sci-Fi Epic")
                XCTAssertEqual(details.tagline, "Fear is the mind killer")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }

        wait(for: [expectation], timeout: 1)
    }

    func test_getGenres_success_returnsMappedGenres() {
        // Given
        mockService.mockGenres = [
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Drama"),
        ]

        let expectation = expectation(description: "Genres mapped")

        // When
        sut.getGenres { result in
            switch result {
            case let .success(genres):
                XCTAssertEqual(genres.count, 2)
                XCTAssertEqual(genres.first?.name, "Action")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }

        wait(for: [expectation], timeout: 1)
    }
}
