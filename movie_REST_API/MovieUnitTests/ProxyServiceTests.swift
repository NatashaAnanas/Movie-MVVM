// ProxyServiceTests.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Тесты для ProxyService
final class ProxyServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockNumber = 4
        static let mockText = "house"
    }

    // MARK: - Public Properties

    var imageNetworkService: ImageNetworkServiceProtocol?
    var fileService: FileServiceProtocol?
    var mockProxy: MockProxyService?
    let mockPath = Constants.mockText

    // MARK: - Public Methods

    override func setUp() {
        imageNetworkService = ImageNetworkService()
        fileService = FileService()
        mockProxy = MockProxyService()
    }

    override func tearDown() {
        mockProxy = nil
    }

    func testLoadImage() {
        mockProxy?.loadImage(by: mockPath, completion: { result in
            switch result {
            case let .success(mockData):
                let data = Data(count: Constants.mockNumber)
                XCTAssertEqual(mockData, data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }
}