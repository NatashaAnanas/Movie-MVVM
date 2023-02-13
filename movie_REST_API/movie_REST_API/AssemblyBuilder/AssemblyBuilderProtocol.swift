// AssemblyBuilderProtocol.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Протокол для AssemblyBuilder
protocol AssemblyBuilderProtocol {
    func createMovieModule() -> UIViewController
    func createInfoMovieModule(movie: Movie) -> UIViewController
}
