//
//  MovieListViewModel.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 03.02.2024.
//

import Foundation

final class MovieListViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[MovieListCellViewModel]> = Observable([])
    var dataSource: MovieModel?
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.dataSource?.results.count ?? 0
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func getData() {
        
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APICaller.getMovies { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                self?.dataSource = data
                self?.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    } 
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSource?.results.compactMap { MovieListCellViewModel(movie: $0) } 
    }
}
