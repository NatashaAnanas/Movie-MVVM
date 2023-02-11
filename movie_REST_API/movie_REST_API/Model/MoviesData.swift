// MoviesData.swift
// Copyright © Natasha Ananas. All rights reserved.

/// Moдель массив фильмов
struct MoviesData: Codable {
    /// Массив с фильмами
    let movies: [Movie]

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
