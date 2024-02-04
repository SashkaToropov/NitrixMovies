//
//  MovieListCellViewModel.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 04.02.2024.
//

import Foundation

class MovieListCellViewModel {
    
    var id: Int
    var title: String
    var date: Date
    var rating: String
    var imageURL: URL?
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.date = movie.releaseDate.convertToDate()
        self.rating = "\((movie.voteAverage * 10).rounded() / 10)/10"
        self.imageURL = makeImageURL(movie.posterPath)
    }
    
    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstants.shared.imageServerAddress)\(imageCode)")
    }
}
