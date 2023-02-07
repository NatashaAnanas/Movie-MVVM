// AssemblyBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для AssemblyBuilder
protocol AssemblyBuilderProtocol {
    func createMovieModule() -> UIViewController
    func createInfoMovieModule(movie: Movie) -> UIViewController
}

/// AssemblyBuilder
final class AssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Public methods

    func createMovieModule() -> UIViewController {
        let networkService = NetworkService()
        let imageService = ImageService()
        let viewModel = MovieViewModel(networkService: networkService, imageService: imageService)
        let viewController = MovieViewController(movieViewModel: viewModel)
        return viewController
    }

    func createInfoMovieModule(movie: Movie) -> UIViewController {
        let networkService = NetworkService()
        let imageService = ImageService()
        let viewModel = ActorViewModel(networkService: networkService, imageService: imageService)
        let viewController = InfoMovieViewController(actorViewModel: viewModel, movie: movie)
        return viewController
    }
}
