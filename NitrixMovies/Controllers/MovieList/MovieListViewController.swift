//
//  MovieListViewController.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 02.02.2024.
//

import UIKit
import CoreData

final class MovieListViewController: UIViewController {
    
    var viewModel = MovieListViewModel()
    
    var cellDataSource: [MovieListCellViewModel] = []
    
    var dbService = DBService()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.minimumPressDuration = 0.5
        return longPress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        bindViewModel()
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getData()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        setupTableView()
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let self = self, let movies = movies else { return }
            self.cellDataSource = movies
            self.reloadTableView()
        }
    }
    
    func presentDetailsViewController(movie: Movie) {
        let detailsViewModel = DetailsMovieViewModel(movie: movie)
        let detailsViewController = DetailsMovieViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    @objc func handleLongPress() {
        let gestureLocation = longPressGesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: gestureLocation)
        if longPressGesture.state == UIGestureRecognizer.State.began {
            let movie = cellDataSource[indexPath!.row]
            
            if !dbService.isMovieAlreadyFavorite(movie: movie) {
                
                APICaller.getGenreName(for: movie.genreIds) { genreNames in
                    guard let genreNames = genreNames else {
                        return
                    }
                    
                    
                    DispatchQueue.main.async {
                        let favoriteMovie = FavoriteMovie(context: self.dbService.context)
                        favoriteMovie.title = movie.title
                        favoriteMovie.genre = genreNames.joined(separator: ", ")
                        favoriteMovie.date = movie.date
                        self.dbService.saveContext()
                        
                        let ac = UIAlertController(title: "Movie added to favorites✅", message: nil, preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            } else {
                let ac = UIAlertController(title: "Do not repeat yourself😄", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            }
        }
    }
}

private extension MovieListViewController {
    
    private func setConstraints() {
        
        [tableView, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

