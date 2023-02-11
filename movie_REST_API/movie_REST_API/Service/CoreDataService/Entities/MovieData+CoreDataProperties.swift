// MovieData+CoreDataProperties.swift
// Copyright © Natasha Ananas. All rights reserved.

import CoreData
import Foundation

/// MovieData CoreData
public extension MovieData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieData> {
        NSFetchRequest<MovieData>(entityName: "MovieData")
    }
    /// Идентификатор фильма
    @NSManaged var id: Int64
    /// Название фильма
    @NSManaged var title: String?
    /// Дата релиза фильма
    @NSManaged var year: String?
    /// Рейтинг фильма
    @NSManaged var rate: Double
    /// Ссылка на постер фильма
    @NSManaged var posterImageURLString: String?
    /// Краткое описание фильма
    @NSManaged var descript: String?
    /// Ссылка на обложку фильма
    @NSManaged var presentImageURLString: String?
    /// Все фильмы
    @NSManaged var all: Bool
    /// Популярные вильмы
    @NSManaged var popular: Bool
}
