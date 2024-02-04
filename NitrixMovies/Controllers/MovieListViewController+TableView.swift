//
//  MovieListViewController+TableView.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 03.02.2024.
//

import UIKit

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        view.backgroundColor = .white
        self.tableView.backgroundColor = .clear
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerCells()
    }
    
    func registerCells() {
        tableView.register(MovieListCell.self, forCellReuseIdentifier: MovieListCell.cellIdentifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.cellIdentifier,
                                                       for: indexPath) as? MovieListCell else {
              return UITableViewCell()
          }
        
        let cellViewModel = cellDataSource[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
}
