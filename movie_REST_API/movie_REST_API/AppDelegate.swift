// AppDelegate.swift
// Copyright © Natasha Ananas. All rights reserved.

import CoreData
import UIKit

/// AppDelegate
@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Private Constants

    private enum Constants {
        static let coreDataText = "CoreData"
    }

    // MARK: - Public Properties

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.coreDataText)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError(error.localizedDescription)
            }
        })
        return container
    }()

    // MARK: - Public Methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        true
    }
}
