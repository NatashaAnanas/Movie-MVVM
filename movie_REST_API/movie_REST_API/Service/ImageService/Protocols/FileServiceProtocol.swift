// FileServiceProtocol.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Протокол работы с файловым менеджером
protocol FileServiceProtocol {
    func getImageFromCache(url: String) -> Data?
    func saveImageToCache(url: String, data: Data)
}
