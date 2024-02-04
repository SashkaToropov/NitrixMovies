//
//  MovieListViewController.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 02.02.2024.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    var viewModel = MovieListViewModel()
    
    var cellDataSource: [MovieListCellViewModel] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        bindViewModel()
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

