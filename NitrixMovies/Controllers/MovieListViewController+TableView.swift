//
//  MovieListViewController+TableView.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 03.02.2024.
//

import UIKit

extension MovieListViewController {
    
    func setupTableView() {
        self.tableView.backgroundColor = .green
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerCells()
    }
    
    func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Movie \(indexPath.row)"
        return cell
    }
}
