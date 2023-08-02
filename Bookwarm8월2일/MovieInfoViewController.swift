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
    var rTime: Int = 0
    var rDate: String = ""
    
    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieInformation: UILabel!
    @IBOutlet var movieOverview: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let xmark = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .red
        
        
        moviePoster.image = UIImage(named: Poster)
        movieInformation.numberOfLines = 0
        movieInformation.text = #" \#(mTitle) \#n \#(movieRate)점 \#n \#(rTime)분 \#n \#(rDate)"#
        movieOverview.text = overview
    }
    
    
    
    @objc
    func closeButtonClicked(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
        
    }
    
    
    func setCell(data: Movie) {
        Poster = data.image
        mTitle = data.title
        overview = data.overview
        movieRate = data.rate
        rTime = data.runtime
        rDate = data.releaseDate
    }
}
