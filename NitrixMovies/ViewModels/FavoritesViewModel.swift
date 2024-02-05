//
//  FavoritesViewModel.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 05.02.2024.
//

import Foundation

class FavoritesViewModel {
    
    let favoriteMovies: [FavoriteMovie] = []
    
    func numberOfSections() -> Int {
        1
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        50
    }
}

