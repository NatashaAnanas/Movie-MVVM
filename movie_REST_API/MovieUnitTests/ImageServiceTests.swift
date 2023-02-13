// ImageServiceTests.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Tестирование сервиса по загрузке фото
final class ImageServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockNumber = 4
        static let mockText = "house"
    }

    // MARK: - Public Properties

    var imageService: ImageService?
    var imageNetworkService: ImageNetworkService?
    var fileService: FileService?
    var mockProxy: MockProxyService?
    let mockPath = Constants.mockText

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        mockProxy = MockProxyService()
        guard let mockProxy = mockProxy else { return }
        imageService = ImageService(proxyService: mockProxy)
    }

    override func tearDown() {
        super.tearDown()
        imageService = nil
    }

    func testLoadImage() {
        imageService?.proxyService.loadImage(by: mockPath, completion: { result in
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
