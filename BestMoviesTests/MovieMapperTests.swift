//
//  MovieMapperTests.swift
//  BestMoviesTests
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

@testable import BestMovies
import XCTest

final class MovieMapperTests: XCTestCase {
    func test_mapSingleMovie() {
        let dto = Movie(
            id: 42,
            title: "Inception",
            overview: "Dream layers",
            posterPath: "/image.jpg",
            voteAverage: 8.8,
            genreIds: [1, 2]
        )
        GenreMapping.update(with: [
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Sci-Fi"),
        ])

        let entity = MovieMapper.map(dto)

        XCTAssertEqual(entity.id, 42)
        XCTAssertEqual(entity.title, "Inception")
        XCTAssertEqual(entity.rating, 8.8)
        XCTAssertEqual(entity.genreNames, "Action, Sci-Fi")
    }
}
