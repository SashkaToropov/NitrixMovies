//
//  MovieListViewModel.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 03.02.2024.
//

import Foundation

class MovieListViewModel {
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        10
    }
    
    func getData() {
        APICaller.getMovies { result in
            switch result {
            case .success(let data):
                print("Count: \(data.results.count))")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
