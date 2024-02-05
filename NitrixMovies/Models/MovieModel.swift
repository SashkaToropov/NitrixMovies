//
//  MovieModel.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 03.02.2024.
//

import Foundation

struct MovieModel: Codable {
    let results: [Movie]
}

// MARK: - Result
struct Movie: Codable {
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let overview: String
    let posterPath, releaseDate, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
