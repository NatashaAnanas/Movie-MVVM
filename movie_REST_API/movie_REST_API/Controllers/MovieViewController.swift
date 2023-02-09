// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главная страница c фильмами
final class MovieViewController: UIViewController {
    // MARK: - Private Constant

    private enum Constant {
        static let filmIdentifier = "film"
        static let allFilmString = "Все фильмы"
        static let popularFilmString = "Популярное"
        static let filmsString = "Фильмы"
        static let baseImageName = "фон4"
        static let baseImageFilmName = "film"
        static let newFilmString = "Новинки"
        static let errorText = "Error"
    }

    // MARK: - Private Visual Components

    private let newButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle(Constant.newFilmString, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let baseImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: Constant.baseImageFilmName)
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let popularButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor

        button.layer.shadowRadius = 9.0
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)

        button.backgroundColor = .systemBlue
        button.setTitle(Constant.allFilmString, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let rateButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 9.0
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        button.backgroundColor = .systemCyan
        button.setTitle(Constant.popularFilmString, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundView = UIImageView(image: UIImage(named: Constant.baseImageName))
        tableView.register(MovieViewCell.self, forCellReuseIdentifier: Constant.filmIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Public Properties

    var toInfoVC: MovieHandler?
    var moviesDataStatus: MoviesDataStatus = .loading {
        didSet {
            view.setNeedsLayout()
        }
    }

    // MARK: - Private Properties

    private var movieViewModel: MovieViewModelProtocol?

    // MARK: - Initializers

    convenience init(movieViewModel: MovieViewModelProtocol) {
        self.init()
        self.movieViewModel = movieViewModel
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        setupTableViewDelegats()
        setupAction()
        setConstraint()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        switch moviesDataStatus {
        case .loading:
            fetchMoviesData()
        case .failure:
            showAlert(title: nil, message: Constant.errorText) {}
        }
    }

    // MARK: - Private Method

    private func setupAction() {
        popularButton.addTarget(self, action: #selector(chooseMovieButtonAction(sender:)), for: .touchUpInside)
        rateButton.addTarget(self, action: #selector(chooseMovieButtonAction(sender:)), for: .touchUpInside)
    }

    private func setupMoviesDataStatus() {
        movieViewModel?.moviesDataStatus = { [weak self] status in
            self?.moviesDataStatus = status
        }
    }

    private func fetchMoviesData() {
        movieViewModel?.fetchMoviesData { [weak self] in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
    }

    private func createUI() {
        setupMoviesDataStatus()
        title = Constant.filmsString
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black]
        createBackgroundImage()
        view.addSubviews(baseImageView, movieTableView, popularButton, rateButton, newButton)
    }

    private func createBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: Constant.baseImageName)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }

    private func setupTableViewDelegats() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }

    private func setConstraint() {
        setConstraintTableView()
        setConstraintButtons()
        setConstraintImage()
        setConstraintNewButton()
    }

    private func setConstraintTableView() {
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: baseImageView.bottomAnchor, constant: 5),
            movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    private func setConstraintButtons() {
        NSLayoutConstraint.activate([
            popularButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            popularButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            popularButton.widthAnchor.constraint(equalToConstant: 150),
            popularButton.heightAnchor.constraint(equalToConstant: 40),
        ])

        NSLayoutConstraint.activate([
            rateButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            rateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            rateButton.widthAnchor.constraint(equalToConstant: 150),
            rateButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    private func setConstraintImage() {
        NSLayoutConstraint.activate([
            baseImageView.topAnchor.constraint(equalTo: rateButton.bottomAnchor, constant: 10),
            baseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            baseImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            baseImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setConstraintNewButton() {
        NSLayoutConstraint.activate([
            newButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            newButton.heightAnchor.constraint(equalToConstant: 35),
            newButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func goToInfoVC(indexPath: IndexPath) {
        guard let movie = movieViewModel?.cellForRowAt(indexPath: indexPath) else { return }
        toInfoVC?(movie)
    }

    @objc private func chooseMovieButtonAction(sender: UIButton) {
        if (movieViewModel?.isPressed) != nil {
            popularButton.backgroundColor = .systemCyan
            rateButton.backgroundColor = .systemBlue
            movieViewModel?.isPressed = false
        } else {
            popularButton.backgroundColor = .systemBlue
            rateButton.backgroundColor = .systemCyan
            movieViewModel?.isPressed = true
        }

        switch sender.tag {
        case 0:
            movieViewModel?.urlMovie = NetworkService.Constants.allFilmURLString
            moviesDataStatus = .loading
        case 1:
            movieViewModel?.urlMovie = NetworkService.Constants.popularFilmURLString
            moviesDataStatus = .loading
        default:
            break
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieViewModel?.numberOfRowsInSection(section: section) ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.filmIdentifier,
            for: indexPath
        ) as? MovieViewCell else { return UITableViewCell() }

        guard let movie = movieViewModel?.cellForRowAt(indexPath: indexPath) else { return UITableViewCell() }
        cell.setCellWithValues(movie, movieViewModel: movieViewModel)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell.selectionStyle = .none
        cell.backgroundColor = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToInfoVC(indexPath: indexPath)
    }
}
