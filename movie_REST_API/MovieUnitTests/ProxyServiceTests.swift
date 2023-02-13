// ProxyServiceTests.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Tестирование прокси сервиса
final class ProxyServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockNumber = 4
        static let mockText = "house"
    }

    // MARK: - Public Properties

    let mockPath = Constants.mockText
    var imageNetworkService: ImageNetworkServiceProtocol?
    var fileService: FileServiceProtocol?
    var mockProxy: MockProxyService?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        imageNetworkService = ImageNetworkService()
        fileService = FileService()
        mockProxy = MockProxyService()
    }

    override func tearDown() {
        super.tearDown()
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
