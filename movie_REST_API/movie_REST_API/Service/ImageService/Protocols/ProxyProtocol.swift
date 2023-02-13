// ProxyProtocol.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Протокол загрузки изображения
protocol ProxyProtocol {
    var imageNetworkService: ImageNetworkServiceProtocol { get }
    var fileService: FileServiceProtocol { get }
    func loadImage(by url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
