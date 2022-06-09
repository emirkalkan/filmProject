//
//  Movie.swift
//  filmProject
//
//  Created by Emir Kalkan on 5.06.2022.
//

import Foundation

struct MovieResult: Codable {
    let Search: [Movie]
}

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}

struct MoviesData: Codable {
    let Title: String?
    let Year: String?
    let Released: String?
    let Plot: String?
    let Poster: String
    let imdbRating: String?
    let imdbID: String?
    let `Type`: String?
    let Genre: String?
    let Director: String?
    let Actors: String?
    
    private enum CodingKeys: String, CodingKey {
        case Title, Year, Released, Plot, Poster, imdbRating, imdbID, `Type`, Genre, Director, Actors
    }
}
