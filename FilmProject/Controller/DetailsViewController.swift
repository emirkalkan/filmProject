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
        //getMovieDetails()
        let backButton = UIBarButtonItem()
        backButton.title = "\(searchTitle)"
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        plotLabel.text = searchTitle
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let url = URL(string: "\(Constants.movieDetail+Constants.imdbKey+imdbId)")
        NetworkService().getMovieDetails(url: url!, imdbId: imdbId) { movie in
            DispatchQueue.main.async {
                let url = movie?.Poster
                if let data = try? Data(contentsOf: URL(string: url!)!) {
                    self.posterImageView.image = UIImage(data: data)
                }
                self.titleLabel.text = movie?.Title
                self.yearLabel.text = movie?.Year
                self.plotLabel.text = movie?.Plot
                self.genreLabel.text = movie?.Genre
            }
        }
    }
}
