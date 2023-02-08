// BaseCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Базовый координатор
class BaseCoordinator {
    // MARK: - Public Properties

    var childCoordinators: [BaseCoordinator] = []

    // MARK: - Initializers

    required init(assemblyBuilder: AssemblyBuilderProtocol, navController: UINavigationController? = nil) {}

    // MARK: - Public Methods

    func start() {}

    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: BaseCoordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else { return }
        for (index, element) in childCoordinators.reversed().enumerated() where
            element === coordinator
        {
            childCoordinators.remove(at: index)
            break
        }
    }

    func setAsRoot(_ controller: UIViewController) {
        if #available(iOS 13, *) {
            let sceneDelegate =
                UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = controller
        } else {
            UIApplication.shared.keyWindow?.rootViewController = controller
        }
    }
}
