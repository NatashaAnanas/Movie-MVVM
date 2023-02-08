//
//  ActorViewModelProtocol.swift
//  movie_REST_API
//
//  Created by Анастасия Козлова on 08.02.2023.
//

import UIKit

/// Протокол ActorViewModel
protocol ActorViewModelProtocol {
    var isPressed: Bool { get set }
    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> ())
    func fetchActorsData(id: Int?, completion: @escaping ([Actor]) -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> Actor
}
