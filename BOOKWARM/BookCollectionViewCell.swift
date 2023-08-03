//
//  BookCollectionViewCell.swift
//  BOOKWARM
//
//  Created by hoon on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieRate: UILabel!
    
    @IBOutlet var likeButton: UIButton!
    
    func setCell(row: Movie) {

        moviePoster.image = UIImage(named: row.image)
        movieTitle.text = row.title
        movieRate.text = String(row.rate)

        backView.layer.cornerRadius = 15
        backView.backgroundColor = .systemGray5

        movieTitle.textColor = .black
        movieRate.textColor = .black
        movieTitle.font = UIFont.boldSystemFont(ofSize: 15)

    }
    
    
    
    func setLikeButton(data: Movie) {
        var result = ""
        
        if data.like {
            result = "star.fill"
        } else {
            result = "star"
        }
        likeButton.setImage(UIImage(systemName: result), for: .normal)
    }
    
    
    
    
    
}
