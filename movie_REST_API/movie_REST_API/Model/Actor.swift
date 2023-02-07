// Actor.swift
// Copyright © RoadMap. All rights reserved.

/// Модель Актеры
struct Actor: Decodable {
    /// Имя актера
    let name: String?
    /// Фото актера
    let actorImageURLString: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case actorImageURLString = "profile_path"
    }
}
