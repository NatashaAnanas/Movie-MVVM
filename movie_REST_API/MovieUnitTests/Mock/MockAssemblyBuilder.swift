// MockAssemblyBuilder.swift
// Copyright © Natasha Ananas. All rights reserved.

import XCTest

@testable import movie_REST_API

/// Mock AssemblyBuilder
final class MockAssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyText = ""
        static let mockIdInt = 1
        static let mockDouble = 1.0
        static let mockStringText = "hello"
    }

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

    func createMovieModule() -> UIViewController {
        let networkService = MockNetworkService()
        let keychainService = MockKeychainService()
        let imageService = MockImageService()
        let coreDataService = MockCoreDataService()
        let viewModel = MovieViewModel(
            networkService: networkService,
            imageService: imageService,
            keychainService: keychainService,
            coreDataService: coreDataService
        )

        let viewController = MovieViewController(movieViewModel: viewModel)
        return viewController
    }

    func createInfoMovieModule(movie: movie_REST_API.Movie) -> UIViewController {
        let networkService = MockNetworkService()
        let imageService = MockImageService()
        let viewModel = ActorViewModel(
            networkService: networkService,
            imageService: imageService
        )
        let viewController = ActorMovieViewController(
            actorViewModel: viewModel,
            movie: mockMovie
        )
        return viewController
    }
}
