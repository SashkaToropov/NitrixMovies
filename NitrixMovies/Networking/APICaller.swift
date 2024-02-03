//
//  APICaller.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 03.02.2024.
//

import Foundation

class APICaller {
    
    typealias completionHandler = (_ result: Result<MovieModel,NetworkError>) -> Void
    
    static func getMovies(completionHandler: @escaping completionHandler) {
        
        let urlString = NetworkConstants.shared.serverAddress + "/discover/movie?api_key=" + NetworkConstants.shared.apiKey
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, URLResponse, error in
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(MovieModel.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}
