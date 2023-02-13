// MockImageService.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Мок сервиса по загрузке фото
final class MockImageService: ImageServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockText = "house"
        static let mockNumber = 4
    }

    // MARK: - Public Properties

    let mockPath = Constants.mockText

    // MARK: - Public Methods

    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if imageURLPath == mockPath {
            let data = Data(count: Constants.mockNumber)
            completion(.success(data))
        }
    }
}
