// AssemblyBuilderTests.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Тестирование AssemblyBuilder
final class AssemblyBuilderTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockText = "house"
        static let emptyText = ""
        static let mockIdInt = 1
        static let mockDouble = 1.0
        static let mockStringText = "hello"
    }
    
    // MARK: - Public Properties
    
    var assemblyBuilder: AssemblyBuilderProtocol?

    // MARK: - Private Properties

    private let mockMovie = Movie(
        id: Constants.mockIdInt,
        title: Constants.mockStringText,
        year: Constants.mockStringText,
        rate: Constants.mockDouble,
        posterImageURLString: Constants.mockStringText,
        description: Constants.mockStringText,
        presentImageURLString: Constants.mockStringText
    )


    // MARK: - Public Methods

    override func setUp() {
        assemblyBuilder = AssemblyBuilder()
    }

    override func tearDown() {
        assemblyBuilder = nil
    }

    func testBuildMovieVC() {
        let movieViewController = assemblyBuilder?.createMovieModule()
        XCTAssertTrue(movieViewController is MovieViewController)
    }

    func testBuildActorVC() {
        let actorMovieViewController = assemblyBuilder?.createInfoMovieModule(movie: mockMovie)
        XCTAssertTrue(actorMovieViewController is ActorMovieViewController)
    }
}
