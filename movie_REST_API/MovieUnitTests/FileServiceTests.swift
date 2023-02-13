// FileServiceTests.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Tестирование файлового сервиса
final class FileServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockText = "house"
        static let mockNumber = 4
    }

    // MARK: - Public Properties

    let mockPath = Constants.mockText
    let mockProxy = MockProxyService()
    var fileService: FileServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        fileService = FileService()
    }

    override func tearDown() {
        super.tearDown()
        fileService = nil
    }

    func testSaveAndLoadImage() {
        let mockData = Data(count: Constants.mockNumber)
        fileService?.saveImageToCache(url: Constants.mockText, data: mockData)
        let data = fileService?.getImageFromCache(url: Constants.mockText)
        XCTAssertEqual(mockData, data)
    }
}
