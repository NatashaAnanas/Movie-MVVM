// ImageNetworkServiceProtocol.swift
// Copyright © Natasha Ananas. All rights reserved.

import Foundation

/// Протокол загрузки картинки из сети
protocol ImageNetworkServiceProtocol {
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> ())
}
