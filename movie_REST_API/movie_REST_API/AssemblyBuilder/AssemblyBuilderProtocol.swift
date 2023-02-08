// AssemblyBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для AssemblyBuilder
protocol AssemblyBuilderProtocol {
    func createMovieModule() -> UIViewController
    func createInfoMovieModule(movie: Movie) -> UIViewController
}
