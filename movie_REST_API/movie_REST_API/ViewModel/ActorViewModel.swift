// ActorViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол ActorViewModel
protocol ActorViewModelProtocol {
    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> ())
    func fetchActorsData(id: Int?, completion: @escaping ([Actor]) -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> Actor
}

/// Вью - модель InfoMovieViewController
final class ActorViewModel: ActorViewModelProtocol {
    // MARK: - Private Constant

    private enum Constant {
        static let firstPartURLString = "https://api.themoviedb.org/3/movie/"
        static let secondPartURLString = "/credits?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US"
        static let errorString = "Error processing json data: "
    }

    // MARK: - Private Properties

    private let imageService: ImageServiceProtocol?
    private var networkService: NetworkServiceProtocol?
    private var actors: [Actor] = []

    // MARK: - Initializers

    init(networkService: NetworkServiceProtocol, imageService: ImageServiceProtocol?) {
        self.networkService = networkService
        self.imageService = imageService
    }

    // MARK: - Public Method

    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> ()) {
        imageService?.fetchImage(imageURLPath: imageURLPath, completion: { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }

    func fetchActorsData(id: Int?, completion: @escaping ([Actor]) -> ()) {
        guard let idMovie = id else { return }
        let urlActor = "\(Constant.firstPartURLString)\(String(idMovie))\(Constant.secondPartURLString)"
        networkService?.getActorData(actorURL: urlActor) { [weak self] result in
            switch result {
            case let .success(listOf):
                guard let list = listOf else { return }
                self?.actors = list.actors
                completion(list.actors)
            case let .failure(error):
                print(Constant.errorString, error)
            }
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        if actors.count != 0 {
            return actors.count
        }
        return 0
    }

    func cellForRowAt(indexPath: IndexPath) -> Actor {
        actors[indexPath.row]
    }
}