// MainCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias VoidHandler = () -> ()
/// Главный координатор
final class MainCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var onFinishFlow: VoidHandler?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var navController: UINavigationController?

    // MARK: - Initializers

    required init(assemblyBuilder: AssemblyBuilderProtocol, navController: UINavigationController? = nil) {
        self.assemblyBuilder = assemblyBuilder
        self.navController = navController
        super.init(assemblyBuilder: assemblyBuilder, navController: navController)
    }

    // MARK: - Life cycle

    override func start() {
        showMainScreen()
    }

    // MARK: - Private methods

    private func showMainScreen() {
        guard let controller = assemblyBuilder?.createMovieModule() as? MovieViewController else { fatalError() }
        controller.toInfoVC = { [weak self] movie in
            self?.showDetailViewController(movie: movie)
        }
        if navController == nil {
            let navController = UINavigationController(rootViewController: controller)
            self.navController = navController
            setAsRoot(navController)
        } else if let navController = navController {
            navController.pushViewController(controller, animated: true)
            setAsRoot(navController)
        }
    }

    private func showDetailViewController(movie: Movie) {
        guard let controller = assemblyBuilder?.createInfoMovieModule(movie: movie)
            as? InfoMovieViewController
        else { return }
        navController?.pushViewController(controller, animated: true)
    }
}
