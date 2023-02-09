//
//  KeychainServiceProtocol.swift
//  movie_REST_API
//
//  Created by Анастасия Козлова on 09.02.2023.
//

/// Протокол Keychain сервис
protocol KeychainServiceProtocol {
    // MARK: - Public Methods
    func saveKey(_ key: String)
    func getKey() -> String?
}
