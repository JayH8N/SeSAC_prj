//
//  MovieInfoViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/07/31.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    var Poster: String = ""
    var movieInfo: String = ""
    var overview: String = ""
    
    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieInformation: UILabel!
    @IBOutlet var movieOverview: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviePoster.image = UIImage(named: Poster)
        movieInformation.text = movieInfo
        movieOverview.text = overview
    }

    
//    func setScreen(row : Movie) {
//        moviePoster.image = UIImage(named: row.image)
//        movieOverview.text = row.overview
//        movieInformation.text = "\(row.title), \(row.rate), \(row.releaseDate)"
//    }



}
