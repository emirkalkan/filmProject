//
//  NetworkService.swift
//  filmProject
//
//  Created by Emir Kalkan on 5.06.2022.
//

import Foundation
import UIKit

class NetworkService: NSObject {
 
    func getMovie(url: String, query: String, completion: @escaping (MovieResult?) -> ()) {
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=3aea79ac&s=\(query)")!, completionHandler: { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                //convert
                var result: MovieResult?
                
                do{
                    result = try JSONDecoder().decode(MovieResult.self, from: data)
                    completion(result)
                } catch {
                    print("error")
                    completion(nil)
                }
            }
            
        }).resume()
    }
    
    func getMovieDetails(url: URL, imdbId: String, completion: @escaping (MoviesDetail?) -> ()) {
        URLSession.shared.dataTask(with: URL(string: "\(Constants.movieDetail+Constants.imdbKey+imdbId)")!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            //convert
            var result: MoviesDetail?
            
            do{
                result = try JSONDecoder().decode(MoviesDetail.self, from: data)
                completion(result)
            } catch {
                print("error")
                completion(nil)
            }
            
            guard let finalResult = result else { return }
        }).resume()
    }
}
