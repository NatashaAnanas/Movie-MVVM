// MockNetworkService.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Мок сетевого слоя
final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockText = "house"
        static let emptyText = ""
        static let mockIdInt = 1
        static let mockDouble = 1.0
        static let mockStringText = "hello"
    }

    // MARK: - Private Properties

    private let mockMoviesData = MoviesData(movies: [Movie(
        id: Constants.mockIdInt,
        title: Constants.mockStringText,
        year: Constants.mockStringText,
        rate: Constants.mockDouble,
        posterImageURLString: Constants.mockStringText,
        description: Constants.mockStringText,
        presentImageURLString: Constants.mockStringText
    )])

    private let mockActorData = ActorData(actors: [Actor(
        name: Constants.mockStringText,
        actorImageURLString: Constants.mockStringText
    )])

    // MARK: - Public Methods

    func getMoviesData(moviesURL: String, completion: @escaping (Result<movie_REST_API.MoviesData?, Error>) -> ()) {
        completion(.success(mockMoviesData))
    }

    func getActorData(actorURL: String, completion: @escaping (Result<movie_REST_API.ActorData?, Error>) -> ()) {
        completion(.success(mockActorData))
    }
}
