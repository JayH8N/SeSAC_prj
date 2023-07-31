//
//  BookCollectionViewCell.swift
//  BOOKWARM
//
//  Created by hoon on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieRate: UILabel!
    
    func setCell(row: Movie) {
        let color: [UIColor] = [.black, .blue, .brown, .gray, .green, .magenta, .yellow, .systemCyan]
        
        moviePoster.image = UIImage(named: row.poster)
        movieTitle.text = row.title
        movieRate.text = String(row.rate)
        
        backView.layer.cornerRadius = 15
        backView.backgroundColor = color[Int.random(in: 0...color.count - 1)]
        
        movieTitle.textColor = .white
        movieRate.textColor = .white
        movieTitle.font = UIFont.boldSystemFont(ofSize: 15)
        print("\(row.title)")
    }
    
}
