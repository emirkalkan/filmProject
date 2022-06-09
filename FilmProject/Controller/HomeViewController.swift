//
//  HomeViewController.swift
//  filmProject
//
//  Created by Emir Kalkan on 5.06.2022.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    let loadingVC = LoadingViewController()
    
    var movies = [Movie]()
    var query: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cinema"
        searchButton.layer.cornerRadius = 6
        tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        showAnimation()
    }
    override func viewDidAppear(_ animated: Bool) {
        hideAnimation()
    }
    
    func searchMovies() {
        textField.resignFirstResponder()
        
        guard let text = textField.text, !text.isEmpty else {
            
            //refresh tableview
            //DispatchQueue.main.async {
                //loadingVC.dismiss(animated: true, completion: nil)
            Helper().showAlert(controller: self, title: "Error", message: "You have not typed any word yet.")
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
        
        let url = "\(Constants.baseUrl+Constants.movieSearchKey+query)"
        
        NetworkService().getMovie(url: url, query: query) { movie in
            if movie != nil {
                //update movies array
                let newMovies = movie!.Search
                self.movies.append(contentsOf: newMovies)
                
                //refresh tableview
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    Helper().showAlert(controller: self, title: "Error", message: "There is no any film named \(self.query)")
                }
                
            }
            
        }
    }
    
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
    
    //Button
    @IBAction func searchButtonPressed(_ sender: Any) {
        //showAnimation()
        searchMovies()
    }
    
    //helpers
    func showAnimation() {
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
        present(loadingVC, animated: true, completion: nil)
    }
    
    func hideAnimation() {
        loadingVC.dismiss(animated: true, completion: nil)
    }
}
