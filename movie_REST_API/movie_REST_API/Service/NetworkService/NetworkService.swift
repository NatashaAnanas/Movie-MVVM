// NetworkService.swift
// Copyright © Natasha Ananas. All rights reserved.

import Foundation

/// Cетевой слой
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Public Constant

    enum Constants {
        static let errorDataTaskString = "DataTask error: "
        static let emptyResponseString = "Empty Response"
        static let statusCodeString = "Response status code: "
        static let emptyDataString = "Empty Data"
        static let filmURLFirstText = "https://api.themoviedb.org/3/movie/popular?api_key="
        static let filmURLSecondText = "8&language=en-US&page=1"

        static let allFilmURLString =
            "https://api.themoviedb.org/3/movie/popular?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"

//            "https://api.themoviedb.org/3/movie/popular?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"
        static let popularFilmURLString =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=74b256bd9644791fa138aeb51482b3b8&language=en-US&page=1"
    }

    // MARK: - Private Properties

    private var dataTask: URLSessionDataTask?

    // MARK: - Public Methods

    func getMoviesData(moviesURL: String, completion: @escaping (Result<MoviesData?, Error>) -> ()) {
        getData(url: moviesURL, completion: completion)
    }

    func getActorData(actorURL: String, completion: @escaping (Result<ActorData?, Error>) -> ()) {
        getData(url: actorURL, completion: completion)
    }

    // MARK: - Private Methods

    private func getData<T: Decodable>(url: String, completion: @escaping (Result<T?, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard response is HTTPURLResponse else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
