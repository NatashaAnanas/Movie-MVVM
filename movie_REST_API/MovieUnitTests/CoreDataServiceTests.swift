//
//  CoreDataServiceTests.swift
//  MovieUnitTests
//
//  Created by Анастасия Козлова on 12.02.2023.
//

import XCTest

@testable import movie_REST_API

/// Tестирование CoreDataService
final class CoreDataServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockText = "house"
        static let emptyText = ""
        static let mockIdInt = 1
        static let mockDouble = 1.0
        static let mockStringText = "hello"
    }

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

    // MARK: - Public Properties

    var coreDataService: CoreDataServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        coreDataService = CoreDataService()
    }

    override func tearDown() {
        coreDataService = nil
    }

    func testSaveCoreData() {
        coreDataService?.saveMovieCoreData(type: .all, movies: mockMovie)
        let movies = coreDataService?.getMovieCoreData(type: .all)
        XCTAssertNotNil(movies)
    }
}
