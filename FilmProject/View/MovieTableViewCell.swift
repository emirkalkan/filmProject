//
//  MovieTableViewCell.swift
//  filmProject
//
//  Created by Emir Kalkan on 5.06.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieYearLabel: UILabel!
    @IBOutlet var movieGenreLabel: UILabel!
    @IBOutlet var moviePlotLabel: UILabel!
    @IBOutlet var moviePosterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static let identifier = "MovieTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
    }
    
    func configure(with model: Movie) {
        self.movieTitleLabel.text = model.Title
        self.movieYearLabel.text = model.Year
        /*self.movieGenreLabel.text = model.Genre
        self.moviePlotLabel.text = model.Plot*/
        let url = model.Poster
        if let data = try? Data(contentsOf: URL(string: url)!) {
            moviePosterImageView.image = UIImage(data: data)
        }
    }
}
