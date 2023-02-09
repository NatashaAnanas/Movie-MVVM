// MovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью - модель MovieViewController
final class MovieViewModel: MovieViewModelProtocol {
    // MARK: - Private Constant
    
    private enum Constant {
        static let errorString = "Error processing json data: "
    }
    
    // MARK: - Public Properties
    
    var isPressed = true
    var moviesDataStatus: ((MoviesDataStatus) -> ())?
    var urlMovie: String = "" {
        didSet {
            fetchMoviesData {
                print("Обновление")
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let imageService: ImageServiceProtocol?
    private let keychainService: KeychainServiceProtocol
    private var networkService: NetworkServiceProtocol?
    private var movies: [Movie] = []
    
    // MARK: - Initializers
    
    init(networkService: NetworkServiceProtocol?,
         imageService: ImageServiceProtocol?,
         keychainService: KeychainServiceProtocol) {
        self.networkService = networkService
        self.imageService = imageService
        self.keychainService = keychainService
    }
    
    // MARK: - Public Methods
    
    func getKeychain() -> Bool {
        let key = keychainService.getKey()
        guard let key = key else {
            return false
        }
        urlMovie = "\(NetworkService.Constants.filmURLFirstText)\(key)\(NetworkService.Constants.filmURLSecondText)"
        return true
    }
    
    func saveKeychain(key: String) {
        keychainService.saveKey(key)
        urlMovie = "\(NetworkService.Constants.filmURLFirstText)\(key)\(NetworkService.Constants.filmURLSecondText)"
    }
    
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
        imageService?.fetchImage(imageURLPath: "\(ImageNetworkService.Constant.firstPartURLString)\(imageURLPath)",
                                 completion: { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
    
    func fetchMoviesData(completion: @escaping () -> ()) {
        networkService?.getMoviesData(moviesURL: urlMovie) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(listOf):
                guard let list = listOf else { return }
                self.movies = list.movies
                self.moviesDataStatus?(.loading)
                completion()
            case .failure:
                self.moviesDataStatus?(.failure)
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
