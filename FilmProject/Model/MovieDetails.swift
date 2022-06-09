//
//  MovieDetails.swift
//  filmProject
//
//  Created by Emir Kalkan on 9.06.2022.
//

import Foundation

struct MoviesDetail: Codable {
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
