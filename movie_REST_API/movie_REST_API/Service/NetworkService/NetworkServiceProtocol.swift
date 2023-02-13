// NetworkServiceProtocol.swift
// Copyright © Natasha Ananas. All rights reserved.

/// Протокол сетевого слоя
protocol NetworkServiceProtocol {
    func getMoviesData(moviesURL: String, completion: @escaping (Result<MoviesData?, Error>) -> ())
    func getActorData(actorURL: String, completion: @escaping (Result<ActorData?, Error>) -> ())
}
