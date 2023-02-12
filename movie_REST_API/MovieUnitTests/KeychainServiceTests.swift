// KeychainServiceTests.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Тесты для KeychainService
final class KeychainServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockKey = "mockKey"
    }

    // MARK: - Private Properties

    private var keychainService: KeychainServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        keychainService = KeychainService()
    }

    override func tearDown() {
        keychainService = nil
    }

    func testKeychainService() {
        let mockKey = Constants.mockKey
        keychainService?.saveKey(key: mockKey)
        let catchMockKey = keychainService?.getKey()
        XCTAssertNotNil(catchMockKey)
        guard let catchMockKey = catchMockKey else { return }
        XCTAssertEqual(mockKey, catchMockKey)
    }
}
