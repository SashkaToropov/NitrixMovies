//
//  DetailsMovieViewModel.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 04.02.2024.
//

import Foundation

final class DetailsMovieViewModel {
         
    var movieImage: URL?
    var movieTitle: String
    var movieDescription: String
    var movieDate: Date
    var movieId: Int
    
    init(movie: Movie) {        
        self.movieId = movie.id
        self.movieTitle = movie.title
        self.movieDescription = movie.overview
        self.movieDate = movie.releaseDate.convertToDate()
        self.movieImage = makeImageURL(movie.backdropPath)
    }
    
    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstants.shared.imageServerAddress)\(imageCode)")
    }
}
