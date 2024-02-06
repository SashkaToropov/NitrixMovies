//
//  APICaller.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 03.02.2024.
//

import Foundation

struct APICaller {
    static func fetchData<T: Decodable>(from endpoint: EndPoint, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.serverAddress + endpoint.rawValue + NetworkConstants.shared.apiKey
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(.failure(.networkError(error)))
                    return
                }
                
                guard let data = dataResponse else {
                    completionHandler(.failure(.noData))
                    return
                }
                
                do {
                    let resultData = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(resultData))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }.resume()
    }
}

extension APICaller {
    static func getMovies(completionHandler: @escaping (Result<MovieModel, NetworkError>) -> Void) {
        fetchData(from: .movies, completionHandler: completionHandler)
    }
    
    static func getGenreName(for genreIds: [Int], completion: @escaping ([String]?) -> Void) {
        fetchData(from: .genres) { (result: Result<MovieGenres, NetworkError>) in
            switch result {
            case .success(let movieGenres):
                let genreNames = genreIds.compactMap { genreId in
                    movieGenres.genres.first { $0.id == genreId }?.name
                }
                completion(genreNames)
            case .failure:
                completion(nil)
            }
        }
    }
}
