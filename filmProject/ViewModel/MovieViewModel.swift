//
//  MovieViewModel.swift
//  filmProject
//
//  Created by Emir Kalkan on 5.06.2022.
//

import Foundation
import UIKit

protocol MovieViewModelProtocol: NSObject {
    func updateList()
    func navigateToDetailVC(vc: UIViewController)
    func showToast(message:String,font:UIFont, width: Int, height: Int)
}

class MovieViewModel: NSObject {
    
    weak var delegate: MovieViewModelProtocol?
    
    private var networkservice = NetworkService()
    private var movies = [Movie]()
    
    func getData(url: URL, completion: @escaping (Movie?) -> ()) {
    
    }
}

extension MovieViewModel: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    //tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 255
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Show movie details
        if let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController {
            vc.searchTitle = query
            vc.imdbId = movies[indexPath.row].imdbID
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //textField functions
    func textFieldShouldReturn(_ textField: UITextField) {
        searchButtonPressed((Any).self)
        //return true
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        //showAnimation()
        searchMovies()
    }
    
    func searchMovies() {
        textField.resignFirstResponder()
        
        guard let text = textField.text, !text.isEmpty else {
            
            //refresh tableview
            //DispatchQueue.main.async {
                //loadingVC.dismiss(animated: true, completion: nil)
                showAlert(title: "Error", message: "You have not typed any word yet.")
                movies.removeAll()
                //tableView.reloadData()
            //}
            return
        }
        
        movies.removeAll()
        
        //for space issues
        if ((textField.text?.contains(" ")) != nil) {
            var text = textField.text?.replacingOccurrences(of: " ", with: "+")
            query = text!
        } else {
            query = text.replacingOccurrences(of: "", with: "%20")
        }
        
        let urlkey = "https://www.omdbapi.com/?apikey=b40bcdca&s=\(query)&type=movie"
        //api key düzeltilecek
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=3aea79ac&s=\(query)")!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            //convert
            var result: MovieResult?
            
            do{
                result = try JSONDecoder().decode(MovieResult.self, from: data)
            } catch {
                print("error")
                DispatchQueue.main.async {
                    //self.loadingVC.dismiss(animated: true, completion: nil)
                    self.tableView.reloadData()
                    self.showAlert(title: "Error", message: "There is no any film named \(self.query)")
                }
            }
            
            guard let finalResult = result else { return }
            
            //update movies array
            let newMovies = finalResult.Search
            self.movies.append(contentsOf: newMovies)
            
            //refresh tableview
            DispatchQueue.main.async {
                self.hideAnimation()
                self.tableView.reloadData()
            }
        }).resume()
    }
}
