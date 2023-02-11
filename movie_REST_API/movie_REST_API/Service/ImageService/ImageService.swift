// ImageService.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Сервис запроса картинки
final class ImageService: ImageServiceProtocol {
    // MARK: - Public properties

    let proxyService: ProxyProtocol
    
    // MARK: - Initializer
    
    init(proxyService: ProxyProtocol) {
        self.proxyService = proxyService
    }

    // MARK: - Public methods

    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let proxy = ProxyService(imageNetworkService: proxyService.imageNetworkService,
                                 fileService: proxyService.fileService)
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
