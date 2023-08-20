//
//  TVCollectionViewCell.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit
import Kingfisher

class TVCollectionViewCell: UICollectionViewCell {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setImageView()
        setLabel()
    }
    
    
    func setImageView() {
        posterImageView.layer.cornerRadius = 8
        posterImageView.contentMode = .scaleToFill
    }
    
    func setLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 15)
        infoLabel.textColor = .lightGray
        infoLabel.font = .systemFont(ofSize: 11)
    }
    
    func setCell(item: Tv) {
        let imageURL = "https://image.tmdb.org/t/p/w500"
        
        titleLabel.text = item.name
        infoLabel.text = item.contents
        if let url = URL(string: imageURL + item.poster) {
            posterImageView.kf.setImage(with: url)
        }
    }
    
    
    
    

}
