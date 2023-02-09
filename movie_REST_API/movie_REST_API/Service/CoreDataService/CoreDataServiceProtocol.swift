// CoreDataServiceProtocol.swift
// Copyright © Natasha Ananas. All rights reserved.

import Foundation

/// Протокол работы с CoreData
protocol CoreDataServiceProtocol {
    func saveMovieCoreData(type: TypeMovie, movies: [Movie])
    func getMovieCoreData(type: TypeMovie) -> [Movie]?
}
