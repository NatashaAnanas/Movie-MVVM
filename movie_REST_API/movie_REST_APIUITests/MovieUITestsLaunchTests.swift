// MovieUITestsLaunchTests.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

final class MovieUITestsLaunchTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let launchScreenString = "Launch Screen"
    }

    // MARK: - Public Methods

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = Constants.launchScreenString
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
