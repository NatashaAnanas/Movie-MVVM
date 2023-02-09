// KeychainServiceProtocol.swift
// Copyright © Natasha Ananas. All rights reserved.

/// Протокол Keychain сервис
protocol KeychainServiceProtocol {
    // MARK: - Public Methods

    func saveKey(key: String)
    func getKey() -> String?
}
