// MovieViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

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
