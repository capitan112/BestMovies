//
//  TopRatedUITests.swift
//  BestMoviesUITests
//
//  Created by Oleksiy Chebotarov on 22/05/2025.
//

import XCTest

final class TopRatedUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["USE_MOCK_DATA"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func test_searchingEmpty_shouldShowNoResults() {
        // Given
        let searchField = app.searchFields["Search Movies"]

        // When
        XCTAssertTrue(searchField.waitForExistence(timeout: 3))
        searchField.tap()
        searchField.typeText("someunknownmovie")

        // Then
        let emptyLabel = app.staticTexts["emptyLabel"]
        XCTAssertTrue(emptyLabel.waitForExistence(timeout: 2))
        XCTAssertEqual(emptyLabel.label, "No results")
    }
}
