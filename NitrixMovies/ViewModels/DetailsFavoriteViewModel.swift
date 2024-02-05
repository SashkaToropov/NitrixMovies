//
//  DetailsFavoriteViewModel.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 05.02.2024.
//

import Foundation

final class DetailsFavoriteViewModel {
    
    let favoriteMovie: FavoriteMovie

    init(favoriteMovie: FavoriteMovie) {
        self.favoriteMovie = favoriteMovie
    }

    var title: String {
        return favoriteMovie.title ?? "No Title"
    }

    var genres: String {
        return favoriteMovie.genre ?? "No Genre"
    }

    var date: Date {
        return favoriteMovie.date ?? Date()
    }
}
