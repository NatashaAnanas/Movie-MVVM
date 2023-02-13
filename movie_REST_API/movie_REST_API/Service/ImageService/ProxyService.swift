// ProxyService.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Сервис прокси
final class ProxyService: ProxyProtocol {
    // MARK: - Public properties

    let imageNetworkService: ImageNetworkServiceProtocol
    let fileService: FileServiceProtocol

    // MARK: - Initializer

    init(imageNetworkService: ImageNetworkServiceProtocol, fileService: FileServiceProtocol) {
        self.imageNetworkService = imageNetworkService
        self.fileService = fileService
    }

    // MARK: - Public methods

    func loadImage(by url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let image = fileService.getImageFromCache(url: url) else {
            imageNetworkService.fetchImage(imageUrl: url) { [weak self] result in
                switch result {
                case let .success(data):
                    self?.fileService.saveImageToCache(url: url, data: data)
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
            return
        }
        completion(.success(image))
    }
}
