// InfoMovieCell.swift
// Copyright © Natasha Ananas. All rights reserved.

import UIKit

/// Ячейка с фотографиями актеров
final class InfoMovieCell: UICollectionViewCell {
    // MARK: - Private Constant

    private enum Constant {
        static let fatalErrorString = "init(coder:) has not been implemented"
        static let firstPartURLString = "https://image.tmdb.org/t/p/w500"
        static let errorDataTaskString = "DataTask error: "
        static let emptyDataString = "Empty Data"
        static let filmImageName = "film"
    }

    // MARK: - Private Visual Components

    private let personImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.backgroundColor = .none
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let personLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private Properties

    private var actorViewModel: ActorViewModelProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(personLabel)
        addSubview(personImageView)
        setConstraintsImage()
        setConstraintsLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalErrorString)
    }

    // MARK: - Public Method

    func setCellWithValues(_ actors: Actor, actorViewModel: ActorViewModelProtocol?) {
        updateUI(actorImage: actors.actorImageURLString, name: actors.name)
        self.actorViewModel = actorViewModel
    }

    // MARK: - Private Method

    private func setConstraintsImage() {
        NSLayoutConstraint.activate([
            personImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            personImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            personImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            personImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }

    private func setConstraintsLabel() {
        NSLayoutConstraint.activate([
            personLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            personLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            personLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            personLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func updateUI(actorImage: String?, name: String?) {
        personLabel.text = name
        guard let imageString = actorImage else { return }
        let urlString = "\(Constant.firstPartURLString)\(imageString)"
        fetchImageData(url: urlString)
    }

    private func fetchImageData(url: String) {
        actorViewModel?.fetchImage(imageURLPath: url, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    if let image = UIImage(data: data) {
                        self?.personImageView.image = image
                    }
                case .failure:
                    self?.personImageView.image = UIImage(systemName: Constant.filmImageName)
                }
            }
        })
    }
}
