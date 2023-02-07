// ImageNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сервис загрузки картинки из сети
final class ImageNetworkService: ImageNetworkServiceProtocol {
    // MARK: - Private Constant

    enum Constant {
        static let firstPartURLString = "https://image.tmdb.org/t/p/w500"
    }

    // MARK: - Private Properties

    private var dataTask: URLSessionDataTask?

    // MARK: - Public methods

    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: imageUrl) else { return }
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard let data = data else {
                return
            }
            completion(.success(data))
        }
        dataTask?.resume()
    }
}
