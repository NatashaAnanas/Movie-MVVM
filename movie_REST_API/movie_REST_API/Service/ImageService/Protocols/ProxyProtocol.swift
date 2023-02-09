// ProxyProtocol.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Протокол загрузки изображения
protocol ProxyProtocol {
    func loadImage(by url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
