// MoviesData.swift
// Copyright © RoadMap. All rights reserved.

/// Moдель массив фильмов
struct MoviesData: Decodable {
    /// Массив с фильмами
    let movies: [Movie]

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
