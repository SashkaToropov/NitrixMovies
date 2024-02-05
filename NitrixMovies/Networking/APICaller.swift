//
//  APICaller.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 03.02.2024.
//

import Foundation

final class APICaller {
    
    typealias completionHandler = (_ result: Result<MovieModel,NetworkError>) -> Void
    
    static func getMovies(completionHandler: @escaping completionHandler) {
        
        let urlString = NetworkConstants.shared.serverAddress + "/discover/movie?api_key=" + NetworkConstants.shared.apiKey
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, URLResponse, error in
            DispatchQueue.main.async {
                if error == nil,
                   let data = dataResponse,
                   let resultData = try? JSONDecoder().decode(MovieModel.self, from: data) {
                    completionHandler(.success(resultData))
                } else {
                    completionHandler(.failure(.canNotParseData))
                }
            }
        }.resume()
    }
    
    static func getGenreName(for genreIds: [Int], completion: @escaping ([String]?) -> Void) {
           let urlString = NetworkConstants.shared.serverAddress + "/genre/movie/list?api_key=" + NetworkConstants.shared.apiKey
           
        guard let url = URL(string: urlString) else {
             completion(nil)
             return
         }

         URLSession.shared.dataTask(with: url) { (data, response, error) in
             if let error = error {
                 print("Error fetching genre data: \(error)")
                 completion(nil)
                 return
             }

             guard let data = data else {
                 completion(nil)
                 return
             }

             do {
                 let movieGenres = try JSONDecoder().decode(MovieGenres.self, from: data)
                 let genreNames = genreIds.compactMap { genreId in
                     movieGenres.genres.first { $0.id == genreId }?.name
                 }
                 completion(genreNames)
             } catch {
                 print("Error decoding genre data: \(error)")
                 completion(nil)
             }
         }.resume()
       }
}
