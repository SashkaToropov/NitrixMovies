//
//  NetworkConstants.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 03.02.2024.
//

import Foundation

final class NetworkConstants {
    
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init() {}
    
    public var apiKey: String {
        get {
            return "2ccc9fcb3e886fcb5f80015418735095"
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3"
        }
    }
    
    public var imageServerAddress: String {
        get {
            return "https://image.tmdb.org/t/p/w500"
        }
    }
}

