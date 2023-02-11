// SceneDelegate.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// SceneDelegate
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public Properties

    var window: UIWindow?

    // MARK: - Public Methods

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.makeKeyAndVisible()
        let assemblyBuilder = AssemblyBuilder()
        let coordinator = ApplicationCoordinator(assemblyBuilder: assemblyBuilder)
        coordinator.start()
    }
}
