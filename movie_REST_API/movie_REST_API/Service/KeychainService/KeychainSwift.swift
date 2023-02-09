// KeychainSwift.swift
// Copyright © Natasha Ananas. All rights reserved.

import KeychainSwift

/// Keychain сервис
final class KeychainService: KeychainServiceProtocol {
    // MARK: - Constants

    enum Constants {
        static let keyString = "keyText"
//        74b256bd9644791fa138aeb51482b3b
    }

    // MARK: - Public Methods

    func saveKey(key: String) {
        KeychainSwift().set(key, forKey: Constants.keyString)
    }

    func getKey() -> String? {
        KeychainSwift().get(Constants.keyString)
    }
}
