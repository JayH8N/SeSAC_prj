//
//  MovieInfoViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/07/31.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    static let identifier = "MovieInfoViewController"
    
    var Poster: String = ""
    var mTitle: String = ""
    var overview: String = ""
    
    var movieRate: Double = 0.0
    var rTime: Int = 1
    var rDate: String = ""
    
    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieInformation: UILabel!
    @IBOutlet var movieOverview: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviePoster.image = UIImage(named: Poster)
        movieInformation.numberOfLines = 0
        movieInformation.text = #" \#(mTitle) \#n \#(movieRate)점 \#n \#(rTime)분 \#n \#(rDate)"#
        movieOverview.text = overview
    }
}
