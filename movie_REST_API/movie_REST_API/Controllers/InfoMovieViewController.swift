// InfoMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Страница выбранного фильма
final class InfoMovieViewController: UIViewController {
    // MARK: - Private Constant

    private enum Constant {
        static let cellIdentifier = "cell"
        static let errorDataTaskString = "DataTask error: "
        static let emptyDataString = "Empty Data"
        static let firstPartURLString = "https://image.tmdb.org/t/p/w500"
        static let starImageName = "star"
        static let starFillImageName = "star.fill"
        static let emptyString = ""
        static let addFavouriteString = "Фильм добавлен в избранное"
        static let deleteFavouriteString = "Фильм удален из избранного"
        static let baseImageName = "фон5"
        static let watchString = "Смотреть"
    }

    // MARK: - Private Visual Components

    private let descpriptionTextView: UITextView = {
        let text = UITextView()
        text.font = .systemFont(ofSize: 22)
        text.backgroundColor = .none
        text.textColor = .black
        text.textAlignment = .center
        text.showsVerticalScrollIndicator = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private let nameFilmLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .none
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false

        return collection
    }()

    private let movieImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let goToWebButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constant.watchString, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemPurple
        button.setTitleColor(UIColor.black, for: .normal)
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Private Properties

    private var actorViewModel: ActorViewModelProtocol?
    private var isPressed = false
    private var movie: Movie?

    // MARK: - Public Properties

    var idNew: Int?

    // MARK: - Initializers

    convenience init(
        actorViewModel: ActorViewModelProtocol,
        movie: Movie
    ) {
        self.init()
        self.actorViewModel = actorViewModel
        self.movie = movie
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        createNavController()
        createCollectionView()
        setConstraints()
        loadMoviesData()
    }

    // MARK: - Public Method

    func createPresentImage(image: String?) {
        guard let imageString = image else { return }
        let urlString = "\(Constant.firstPartURLString)\(imageString)"
        fetchImageData(url: urlString)
    }

    // MARK: - Private Method

    private func setConstraints() {
        setLabelConstraints()
        setImageConstraints()
        setTextViewConstraints()
        setLabelConstraints()
        setCollectionViewConstraints()
        setButtonConstraints()
    }

    private func fetchImageData(url: String) {
        actorViewModel?.fetchImage(imageURLPath: url, completion: { result in
            switch result {
            case let .success(data):
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.movieImageView.image = image
                    }
                }
            case let .failure(failure):
                print(failure.localizedDescription)
            }
        })
    }

    private func createUI() {
        view.backgroundColor = .black
        createBackground()
        addUI()
        idNew = movie?.id
        createPresentImage(image: movie?.presentImageURLString)
        descpriptionTextView.text = movie?.description
        nameFilmLabel.text = movie?.title
    }

    private func createBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: Constant.baseImageName)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }

    private func addUI() {
        view.addSubviews(nameFilmLabel, movieImageView, descpriptionTextView, goToWebButton)
    }

    private func createNavController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constant.starImageName),
            style: .done,
            target: self,
            action: #selector(starAction)
        )
        navigationItem.rightBarButtonItem?.tintColor = .purple
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    private func createCollectionView() {
        imageCollectionView.register(InfoMovieCell.self, forCellWithReuseIdentifier: Constant.cellIdentifier)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        view.addSubview(imageCollectionView)
    }

    private func setImageConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: nameFilmLabel.bottomAnchor, constant: 10),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            movieImageView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }

    private func setLabelConstraints() {
        NSLayoutConstraint.activate([
            nameFilmLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            nameFilmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameFilmLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameFilmLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    private func setTextViewConstraints() {
        NSLayoutConstraint.activate([
            descpriptionTextView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            descpriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descpriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descpriptionTextView.bottomAnchor.constraint(equalTo: imageCollectionView.topAnchor, constant: -18)
        ])
    }

    private func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            imageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func setButtonConstraints() {
        NSLayoutConstraint.activate([
            goToWebButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 335),
            goToWebButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            goToWebButton.heightAnchor.constraint(equalToConstant: 40),
            goToWebButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func loadMoviesData() {
        actorViewModel?.fetchActorsData(id: movie?.id, completion: { [weak self] _ in
            DispatchQueue.main.async {
                self?.imageCollectionView.reloadData()
            }
        })
    }

    @objc private func starAction() {
        if isPressed == false {
            showAlert(title: Constant.addFavouriteString, message: Constant.emptyString, handler: nil)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: Constant.starFillImageName)
            isPressed = true
        } else {
            showAlert(title: Constant.deleteFavouriteString, message: Constant.emptyString, handler: nil)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: Constant.starImageName)
            isPressed = false
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension InfoMovieViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actorViewModel?.numberOfRowsInSection(section: section) ?? 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.cellIdentifier,
            for: indexPath
        ) as? InfoMovieCell else { return UICollectionViewCell() }

        guard let actor = actorViewModel?.cellForRowAt(indexPath: indexPath) else { return UICollectionViewCell() }
        cell.setCellWithValues(actor, actorViewModel: actorViewModel)
        cell.backgroundColor = .tertiaryLabel
        cell.layer.cornerRadius = 20

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 200, height: 280)
    }
}
