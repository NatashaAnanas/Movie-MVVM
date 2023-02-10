// CoreDataService.swift
// Copyright © Natasha Ananas. All rights reserved.

import CoreData
import UIKit

/// Сервис работы с CoreData
final class CoreDataService: CoreDataServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let movieDataText = "MovieData"
        static let emptyText = ""
    }

    // MARK: - Private Properties

    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    // MARK: - Public Methods

    func saveMovieCoreData(type: TypeMovie, movies: [Movie]) {
        guard let context = context else { return }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.movieDataText, in: context)
        else { return }
        saveMovie(entity: entity, context: context, movies: movies, type: type)
        do {
            try context.save()
        } catch {}
    }

    func getMovieCoreData(type: TypeMovie) -> [Movie]? {
        guard let context = context else { return nil }
        let fetchRequest = NSFetchRequest<MovieData>(entityName: Constants.movieDataText)
        let allMovies = try? context.fetch(fetchRequest)
        guard let allMovies = allMovies else { return nil }
        let movies = getMovie(allMovies: allMovies, type: type)
        return movies
    }

    // MARK: - Private Methods
    
    private func saveMovie(entity: NSEntityDescription,
                           context: NSManagedObjectContext?,
                           movies: [Movie],
                           type: TypeMovie) {
        for movie in movies {
            let managerObject = MovieData(entity: entity, insertInto: context)
            saveType(managerObject: managerObject, type: type)
            managerObject.id = Int64(movie.id ?? 0)
            managerObject.descript = movie.description
            managerObject.title = movie.title
            managerObject.rate = movie.rate ?? 0.0
            managerObject.year = movie.year
            managerObject.posterImageURLString = movie.posterImageURLString
            managerObject.presentImageURLString = movie.presentImageURLString
        }
    }

    private func getMovie(allMovies: [MovieData], type: TypeMovie) -> [Movie]? {
        var movies: [Movie] = []
        for movie in allMovies {
            switch type {
            case .all:
                guard movie.all == true else { continue }
                movies.append(createMovie(movieData: movie))
            case .popular:
                guard movie.popular == true else { continue }
                movies.append(createMovie(movieData: movie))
            }
        }
        return movies
    }
    
    private func saveType(managerObject: MovieData, type: TypeMovie) {
        switch type {
        case .all:
            managerObject.all = true
        case .popular:
            managerObject.popular = true
        }
    }

    private func createMovie(movieData: MovieData) -> Movie {
        Movie(
            id: Int(movieData.id),
            title: movieData.title,
            year: movieData.year,
            rate: movieData.rate,
            posterImageURLString: movieData.posterImageURLString,
            description: movieData.descript,
            presentImageURLString: movieData.presentImageURLString
        )
    }
}
