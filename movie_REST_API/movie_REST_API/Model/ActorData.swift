// ActorData.swift
// Copyright © RoadMap. All rights reserved.

/// Модель массив Актеры
struct ActorData: Decodable {
    /// Массив актеров
    let actors: [Actor]

    private enum CodingKeys: String, CodingKey {
        case actors = "cast"
    }
}
