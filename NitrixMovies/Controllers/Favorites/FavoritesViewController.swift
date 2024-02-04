//
//  FavoritesViewController.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 02.02.2024.
//

import UIKit
import CoreData

final class FavoritesViewController: UIViewController {
    
    let dbService = DBService()
    var favoriteMovies: [FavoriteMovie] = []
    var viewModel = MovieListViewModel()
    var cellDataSource: [MovieListCellViewModel] = []

    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setConstraints()
        fetchData()
        view.backgroundColor = .yellow
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
        tableView.reloadData()
    }
    
    func fetchData() {
        let context = dbService.context
        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        
        do {
            favoriteMovies = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Error fetching data from CoreData: \(error.localizedDescription)")
        }
        
    }
}

private extension FavoritesViewController {
    
    private func setConstraints() {
        
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
