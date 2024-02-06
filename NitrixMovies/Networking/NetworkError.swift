//
//  NetworkError.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 03.02.2024.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case networkError(Error)
    case noData
    case decodingError(Error)
}
