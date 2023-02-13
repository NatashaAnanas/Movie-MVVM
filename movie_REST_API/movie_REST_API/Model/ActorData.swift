// ActorData.swift
// Copyright © Natasha Ananas. All rights reserved.

/// Модель массив Актеры
struct ActorData: Codable {
    /// Массив актеров
    let actors: [Actor]

    private enum CodingKeys: String, CodingKey {
        case actors = "cast"
    }
}
