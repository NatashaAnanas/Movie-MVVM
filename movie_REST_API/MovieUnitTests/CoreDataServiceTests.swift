// CoreDataServiceTests.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Tестирование сервиса coreData
final class CoreDataServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockText = "house"
        static let emptyText = ""
        static let mockIdInt = 1
        static let mockDouble = 1.0
        static let mockStringText = "hello"
    }

    // MARK: - Public Properties
    
    var coreDataService: CoreDataServiceProtocol?
    
    // MARK: - Private Properties

    private let mockMovie = [Movie(
        id: Constants.mockIdInt,
        title: Constants.mockStringText,
        year: Constants.mockStringText,
        rate: Constants.mockDouble,
        posterImageURLString: Constants.mockStringText,
        description: Constants.mockStringText,
        presentImageURLString: Constants.mockStringText
    )]


    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        coreDataService = CoreDataService()
    }

    override func tearDown() {
        super.tearDown()
        coreDataService = nil
    }

    func testSaveCoreData() {
        coreDataService?.saveMovieCoreData(type: .all, movies: mockMovie)
        let movies = coreDataService?.getMovieCoreData(type: .all)
        XCTAssertNotNil(movies)
    }
}
