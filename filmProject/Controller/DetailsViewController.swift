//
//  DetailsViewController.swift
//  filmProject
//
//  Created by Emir Kalkan on 5.06.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    var searchTitle: String = ""
    var imdbId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetails()
        let backButton = UIBarButtonItem()
        backButton.title = "\(searchTitle)"
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        plotLabel.text = searchTitle
        
    }
    
    func getMovieDetails() {
        let url = URL(string: "https://www.omdbapi.com/?apikey=b40bcdca&t=\(searchTitle)")
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=3aea79ac&i=\(imdbId)")!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            //convert
            var result: MoviesData?
            
            do{
                result = try JSONDecoder().decode(MoviesData.self, from: data)
            } catch {
                print("error")
            }
            
            guard let finalResult = result else { return }
            
            DispatchQueue.main.async {
                let url = finalResult.Poster
                if let data = try? Data(contentsOf: URL(string: url)!) {
                    self.posterImageView.image = UIImage(data: data)
                }
                self.titleLabel.text = finalResult.Title
                self.yearLabel.text = finalResult.Year
                self.plotLabel.text = finalResult.Plot
                self.genreLabel.text = finalResult.Genre
            }
        }).resume()
    }
}
