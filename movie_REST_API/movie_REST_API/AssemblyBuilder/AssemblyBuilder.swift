// AssemblyBuilder.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// AssemblyBuilder
final class AssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Public methods

    func createMovieModule() -> UIViewController {
        let networkService = NetworkService()
        let keychainService = KeychainService()
        let imageNetworkService = ImageNetworkService()
        let fileService = FileService()
        let imageService = ImageService(imageNetworkService: imageNetworkService, fileService: fileService)
        let coreDataService = CoreDataService()
        let viewModel = MovieViewModel(
            networkService: networkService,
            imageService: imageService,
            keychainService: keychainService,
            coreDataService: coreDataService
        )
        let viewController = MovieViewController(movieViewModel: viewModel)
        return viewController
    }

    func createInfoMovieModule(movie: Movie) -> UIViewController {
        let networkService = NetworkService()
        let imageNetworkService = ImageNetworkService()
        let fileService = FileService()
        let imageService = ImageService(imageNetworkService: imageNetworkService, fileService: fileService)
        let viewModel = ActorViewModel(networkService: networkService, imageService: imageService)
        let viewController = ActorMovieViewController(actorViewModel: viewModel, movie: movie)
        return viewController
    }
}
