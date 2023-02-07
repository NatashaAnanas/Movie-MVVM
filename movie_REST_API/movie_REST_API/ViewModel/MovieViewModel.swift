// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол MovieViewModel
protocol MovieViewModelProtocol {
    var urlMovie: String { get set }
    var moviesDataStatus: ((MoviesDataStatus) -> ())? { get set }
    func setupColorRate(rating: Double?) -> Colors
    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> ())
    func fetchMoviesData(completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> Movie
}

/// Вью - модель MovieViewController
final class MovieViewModel: MovieViewModelProtocol {
    // MARK: - Private Constant

    private enum Constant {
        static let errorString = "Error processing json data: "
    }

    // MARK: - Public Properties

    var urlMovie = String()
    var moviesDataStatus: ((MoviesDataStatus) -> ())?

    // MARK: - Private Properties

    private let imageService: ImageServiceProtocol?
    private var networkService: NetworkServiceProtocol?
    private var movies: [Movie] = []

    // MARK: - Initializers

    init(networkService: NetworkServiceProtocol?, imageService: ImageServiceProtocol?) {
        self.networkService = networkService
        self.imageService = imageService
    }

    // MARK: - Public Methods

    func setupColorRate(rating: Double?) -> Colors {
        guard let rate = rating else {
            return .defaultColor
        }
        switch rate {
        case 0.0 ... 4.5:
            return .systemRed
        case 4.6 ... 7.4:
            return .systemYellow
        case 7.5 ... 10.00:
            return .systemGreen
        default:
            return .defaultColor
        }
    }

    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> ()) {
        imageService?.fetchImage(imageURLPath: imageURLPath, completion: { result in
            switch result {
            case let .success(data):
                completion(.success(data))
                self.moviesDataStatus?(.success)
            case let .failure(error):
                completion(.failure(error))
                self.moviesDataStatus?(.failure)
            }
        })
    }

    func fetchMoviesData(completion: @escaping () -> ()) {
        networkService?.getMoviesData(moviesURL: urlMovie) { [weak self] result in
            switch result {
            case let .success(listOf):
                guard let list = listOf else { return }
                self?.movies = list.movies
                self?.moviesDataStatus?(.success)
                completion()
            case let .failure(error):
                print(Constant.errorString, error)
                self?.moviesDataStatus?(.failure)
            }
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if movies.count != 0 {
            return movies.count
        }
        return 0
    }

    func cellForRowAt(indexPath: IndexPath) -> Movie {
        movies[indexPath.row]
    }
}