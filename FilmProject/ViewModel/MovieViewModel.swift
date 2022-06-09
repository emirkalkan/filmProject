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
