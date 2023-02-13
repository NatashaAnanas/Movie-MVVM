// MovieUITests.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

final class MovieUITests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let accessibilityIdentifier = "MovieTableView"
    }

    // MARK: - Private Properties

    private let application = XCUIApplication()

    // MARK: - Public Methods

    override func setUpWithError() throws {
        continueAfterFailure = false
        application.launch()
    }

    override func tearDownWithError() throws {}

    func testExample() throws {
        application.swipeUp(velocity: .fast)
        application.swipeDown(velocity: .fast)
        let movieTableView = application.tables.matching(identifier: Constants.accessibilityIdentifier)
        XCTAssertNotNil(movieTableView)
        movieTableView.element.swipeUp(velocity: .slow)
        movieTableView.element.swipeUp(velocity: .fast)
        sleep(1)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
