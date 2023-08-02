//
//  MovieDetailTableViewCell.swift
//  BOOKWARM
//
//  Created by hoon on 2023/08/02.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    
    static let identifier = "MovieDetailTableViewCell"
    
    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moviePoster.layer.cornerRadius = 15
        moviePoster.layer.borderWidth = 2
        moviePoster.layer.borderColor = UIColor.black.cgColor
    }
    
    
    
    func setCell(row: Movie) {
        moviePoster.image = UIImage(named: row.image)
        movieTitle.text = row.title
    }


}
