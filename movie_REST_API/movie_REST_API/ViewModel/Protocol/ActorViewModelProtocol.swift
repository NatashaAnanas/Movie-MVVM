// ActorViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол ActorViewModel
protocol ActorViewModelProtocol {
    var isPressed: Bool { get set }
    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> ())
    func fetchActorsData(id: Int?, completion: @escaping ([Actor]) -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> Actor
}
