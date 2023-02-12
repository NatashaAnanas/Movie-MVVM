// MockKeychainService.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Mock KeychainService
final class MockKeychainService: KeychainServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockKeyText = "mockKey"
    }

    // MARK: - Public Properties

    var keyValue: String?

    // MARK: - Public Methods

    func saveKey(key: String) {
        keyValue = key
    }

    func getKey() -> String? {
        Constants.mockKeyText
    }
}
