// NetworkServiceTests.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Тесты для NetworkService
final class NetworkServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyText = ""
        static let mockMoviesURL = "mockMoviesURL"
        static let mockActorsURL = "mockActorsURL"
    }

    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        networkService = NetworkService()
    }

    override func tearDown() {
        networkService = nil
    }

    func testFetchMovies() {
        let expectation = XCTestExpectation(description: Constants.emptyText)
        networkService?.getMoviesData(moviesURL: Constants.mockMoviesURL) { result in
            switch result {
            case let .success(movies):
                expectation.fulfill()
                XCTAssertNotNil(movies)
            case let .failure(error):
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        }
    }

    func testFetchActors() {
        let expectation = XCTestExpectation(description: Constants.emptyText)
        networkService?.getActorData(actorURL: Constants.mockActorsURL) { result in
            switch result {
            case let .success(actors):
                expectation.fulfill()
                XCTAssertNotNil(actors)
            case let .failure(error):
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        }
    }
}
