// Movie.swift
// Copyright © RoadMap. All rights reserved.

/// Moдель фильмы
struct Movie: Decodable {
    /// Идентификатор фильма
    let id: Int?
    /// Название фильма
    let title: String?
    /// дДта релиза фильма
    let year: String?
    /// Рейтинг фильма
    let rate: Double?
    /// Ссылка на постер фильма
    let posterImageURLString: String?
    /// Краткое описание фильма
    let description: String?
    /// Ссылка на обложку фильма
    let presentImageURLString: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case year = "release_date"
        case rate = "vote_average"
        case posterImageURLString = "poster_path"
        case presentImageURLString = "backdrop_path"
    }
}
