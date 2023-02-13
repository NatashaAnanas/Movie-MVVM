// MovieViewModelProtocol.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Протокол MovieViewModel
protocol MovieViewModelProtocol {
    var urlMovie: String { get set }
    var isPressed: Bool { get set }
    var moviesDataStatus: ((MoviesDataStatus) -> ())? { get set }
    func saveKeychain(key: String)
    func setupColorRate(rating: Double?) -> Colors
    func getKeychain() -> Bool
    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> ())
    func fetchMoviesData(type: TypeMovie, completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> Movie
}
