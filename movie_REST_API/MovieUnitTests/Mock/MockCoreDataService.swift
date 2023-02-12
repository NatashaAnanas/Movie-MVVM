//
//  MockCoreDataService.swift
//  MovieUnitTests
//
//  Created by Анастасия Козлова on 12.02.2023.
//

import XCTest

@testable import movie_REST_API

/// Mock NetworkService
final class MockCoreDataService: CoreDataServiceProtocol {
    
    // MARK: - Private Constants

    private enum Constants {
        static let mockText = "house"
        static let emptyText = ""
        static let mockIdInt = 1
        static let mockDouble = 1.0
        static let mockStringText = "hello"
    }

    // MARK: - Private Properties

    private let mockMovies = [Movie(
        id: Constants.mockIdInt,
        title: Constants.mockStringText,
        year: Constants.mockStringText,
        rate: Constants.mockDouble,
        posterImageURLString: Constants.mockStringText,
        description: Constants.mockStringText,
        presentImageURLString: Constants.mockStringText
    )]
    private var mockEmptyMovies: [Movie]?

    // MARK: - Public Methods

    func saveMovieCoreData(type: movie_REST_API.TypeMovie, movies: [movie_REST_API.Movie]) {
        self.mockEmptyMovies = movies
    }
    
    func getMovieCoreData(type: movie_REST_API.TypeMovie) -> [movie_REST_API.Movie]? {
        mockMovies
    }
}
