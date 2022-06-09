//
//  NetworkService.swift
//  filmProject
//
//  Created by Emir Kalkan on 5.06.2022.
//

import Foundation

class NetworkService {
    
    //private var dataTask: URLSessionDataTask?
    private var urlSession = URLSession()
    /*
    public func getMoviesWithId(imdbId: String, completion: Result<MoviesData, Error>) -> Void {
        //let url = URL(string: "https://www.omdbapi.com/?apikey=3aea79ac&t=\(searchTitle)")
        let url = URL(string: "https://www.omdbapi.com/?apikey=3aea79ac&i=\(imdbId)")
        
        urlSession.dataTask(with: url!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            //convert
            var result: MoviesData?
            
            do{
                result = try JSONDecoder().decode(MoviesData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(error))
                print("error")
            }
        }).resume()
    }*/
}
