//
//  MovieTableViewCell.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/07/28.
//

import UIKit

class MovieList: UITableViewCell {
    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var runTime: UILabel!
    @IBOutlet var rate: UILabel!
    
    @IBOutlet var overview: UITextView!
    
    func configureCell(row: Movie) {
        moviePoster.image = UIImage(named: row.image)
        movieTitle.text = row.title
        releaseDate.text = row.releaseDate
        runTime.text = "\(row.runtime)분"
        rate.text = "\(row.rate)점"
        overview.text = row.overview
     
    }
    
    
    
    

}
