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
    let viewModel = FavoritesViewModel()


    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var longPressGesture: UILongPressGestureRecognizer = {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.minimumPressDuration = 0.5
        return longPress
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
        tableView.reloadData()
    }
    
    func configureViews() {
        view.addSubview(tableView)
        setupTableView()
        fetchData()
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
    
    @objc func handleLongPress() {
        let gestureLocation = longPressGesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: gestureLocation)
        if longPressGesture.state == UIGestureRecognizer.State.began {
            guard let indexPath = indexPath else { return }
            let movie = favoriteMovies[indexPath.row]
                    
                    
                    DispatchQueue.main.async {
                        self.dbService.context.delete(movie)
                        self.favoriteMovies.remove(at: indexPath.row)
                        self.tableView.reloadData()
                        self.dbService.saveContext()
                        let ac = UIAlertController(title: "Movie deleted from favorites😟", message: nil, preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
    
    func presentDetailsViewController(favoriteMovie: FavoriteMovie) {
        let detailsViewModel = DetailsFavoriteViewModel(favoriteMovie: favoriteMovie)
        let detailsViewController = DetailsFavoriteViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

private extension FavoritesViewController {
    
    private func setConstraints() {
        
            tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
