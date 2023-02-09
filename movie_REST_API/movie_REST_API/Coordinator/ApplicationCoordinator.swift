// ApplicationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ApplicationCoordinator
final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Public Properties

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
        toMain()
    }

    // MARK: - Private methods

    private func toMain() {
        guard let assemblyBuilder = assemblyBuilder else { fatalError() }
        let coordinator = MainCoordinator(assemblyBuilder: assemblyBuilder, navController: navController)
        coordinator.onFinishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
