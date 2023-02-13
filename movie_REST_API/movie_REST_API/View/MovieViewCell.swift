// MovieViewCell.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Ячейка с фильмом
final class MovieViewCell: UITableViewCell {
    // MARK: - Private Constant

    private enum Constant {
        static let fatalErrorString = "init(coder:) has not been implemented"
        static let firstPartURLString = "https://image.tmdb.org/t/p/w500"
        static let errorDataTaskString = "DataTask error: "
        static let emptyDataString = "Empty Data"
        static let filmImageName = "film"
    }

    // MARK: - Private Visual Components

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private let nameMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()

    private let descpriptionMovieTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 18)
        text.backgroundColor = .none
        text.textColor = .black

        return text
    }()

    private let rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.backgroundColor = .systemGreen
        label.layer.cornerRadius = 18
        label.clipsToBounds = true
        label.textAlignment = .center

        return label
    }()

    // MARK: - Private Properties

    private var movieViewModel: MovieViewModelProtocol?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalErrorString)
    }

    // MARK: - Public Methods

    func setCellWithValues(_ movie: Movie, movieViewModel: MovieViewModelProtocol?) {
        self.movieViewModel = movieViewModel
        updateUI(
            title: movie.title,
            releaseDate: movie.year,
            rating: movie.rate,
            overview: movie.description,
            poster: movie.posterImageURLString,
            id: movie.id,
            posterImage: movie.presentImageURLString
        )
    }

    // MARK: - Private Methods

    private func createUI() {
        backgroundColor = .black
        addSubview(movieImageView)
        movieImageView.addSubview(rateLabel)
        addSubviews(nameMovieLabel, descpriptionMovieTextView)
    }

    private func setConstraints() {
        setConstraintImageView()
        setConstraintLabel()
        setConstraintTextView()
        setConstraintRateLabel()
    }

    private func setConstraintImageView() {
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            movieImageView.widthAnchor.constraint(equalToConstant: 190),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 5 / 3),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }

    private func setConstraintLabel() {
        NSLayoutConstraint.activate([
            nameMovieLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameMovieLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            nameMovieLabel.widthAnchor.constraint(equalToConstant: 210),
            nameMovieLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setConstraintTextView() {
        NSLayoutConstraint.activate([
            descpriptionMovieTextView.topAnchor.constraint(equalTo: nameMovieLabel.bottomAnchor, constant: 5),
            descpriptionMovieTextView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            descpriptionMovieTextView.widthAnchor.constraint(equalToConstant: 200),
            descpriptionMovieTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setConstraintRateLabel() {
        NSLayoutConstraint.activate([
            rateLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -3),
            rateLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -3),
            rateLabel.widthAnchor.constraint(equalToConstant: 36),
            rateLabel.heightAnchor.constraint(equalTo: rateLabel.widthAnchor)
        ])
    }

    private func updateUI(
        title: String?,
        releaseDate: String?,
        rating: Double?,
        overview: String?,
        poster: String?,
        id: Int?,
        posterImage: String?
    ) {
        nameMovieLabel.text = title
        descpriptionMovieTextView.text = overview
        rateLabel.text = String(rating ?? 0.0)
        let typeColor = movieViewModel?.setupColorRate(rating: rating)
        switch typeColor {
        case .systemRed:
            rateLabel.backgroundColor = .systemRed
        case .systemYellow:
            rateLabel.backgroundColor = .systemYellow
        case .systemGreen:
            rateLabel.backgroundColor = .systemGreen
        default:
            break
        }

        guard let imageString = poster else { return }
//        let urlString = "\(ImageNetworkService.Constant.firstPartURLString)\(imageString)"
        fetchImageData(url: imageString)
    }

    private func fetchImageData(url: String) {
        movieViewModel?.fetchImage(imageURLPath: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    if let image = UIImage(data: data) {
                        self?.movieImageView.image = image
                    }
                case .failure:
                    self?.movieImageView.image = UIImage(systemName: Constant.filmImageName)
                }
            }
        }
    }
}
