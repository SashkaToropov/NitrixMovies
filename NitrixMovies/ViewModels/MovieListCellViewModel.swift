//
//  MovieListCellViewModel.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 04.02.2024.
//

import Foundation

final class MovieListCellViewModel {
    
    var id: Int
    var title: String
    var rating: String?
    var date: Date
    var genreIds: [Int]
    var imageURL: URL?
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.date = movie.releaseDate.convertToDate()
        self.genreIds = movie.genreIDS
        self.rating = "\(calculateRoundedRating(from: movie.voteAverage))/10"
        self.imageURL = makeImageURL(movie.posterPath)
    }
    
    func calculateRoundedRating(from voteAverage: Double) -> String {
        let roundedRating = (voteAverage * 10).rounded() / 10
        return String(format: "%.1f", roundedRating)
    }
    
    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstants.shared.imageServerAddress)\(imageCode)")
    }
}
