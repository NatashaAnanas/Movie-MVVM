// Actor.swift
// Copyright © Natasha Ananas. All rights reserved.

/// Модель Актеры
struct Actor: Codable {
    /// Имя актера
    let name: String?
    /// Фото актера
    let actorImageURLString: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case actorImageURLString = "profile_path"
    }
}
