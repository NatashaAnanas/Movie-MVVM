// ImageService.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Сервис запроса картинки
final class ImageService: ImageServiceProtocol {
    // MARK: - Public properties

    let imageNetworkService: ImageNetworkServiceProtocol
    let fileService: FileServiceProtocol
    
    // MARK: - Initializer

    init(imageNetworkService: ImageNetworkServiceProtocol, fileService: FileServiceProtocol) {
        self.imageNetworkService = imageNetworkService
        self.fileService = fileService
    }

    // MARK: - Public methods

    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let proxy = ProxyService(imageNetworkService: imageNetworkService, fileService: fileService)
        proxy.loadImage(by: imageURLPath) { result in
            switch result {
            case let .success(image):
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
