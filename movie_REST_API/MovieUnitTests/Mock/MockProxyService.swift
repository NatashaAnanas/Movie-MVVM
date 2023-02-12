// MockProxyService.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Mock ProxyService
final class MockProxyService: ProxyProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockValue = 4
        static let mockText = "house"
    }

    // MARK: - Public Properties

    let mockPath = Constants.mockText
    var imageNetworkService: movie_REST_API.ImageNetworkServiceProtocol = ImageNetworkService()
    var fileService: movie_REST_API.FileServiceProtocol = FileService()

    // MARK: - Public Methods

    func loadImage(by url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if url == mockPath {
            let data = Data(count: Constants.mockValue)
            completion(.success(data))
        }
    }
}
