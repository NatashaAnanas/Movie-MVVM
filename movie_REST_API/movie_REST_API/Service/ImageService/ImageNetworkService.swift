// ImageNetworkService.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Сервис загрузки картинки из сети
final class ImageNetworkService: ImageNetworkServiceProtocol {
    // MARK: - Private Constant

    private enum Constant {
        static let firstPartURLString = "https://image.tmdb.org/t/p/w500"
    }

    // MARK: - Private Properties

    private var dataTask: URLSessionDataTask?

    // MARK: - Public methods

    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> ()) {
        let URLImage = "\(Constant.firstPartURLString)\(imageUrl)"
        guard let url = URL(string: URLImage) else { return }
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard response is HTTPURLResponse else {
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
