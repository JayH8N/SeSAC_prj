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
        infoLabel.textColor = .red
        infoLabel.font = .systemFont(ofSize: 11)
    }
    
    func setCell(item: Tv) {
        titleLabel.text = item.name
        infoLabel.text = item.contents
        
        var posterURL = item.poster
        if posterURL == "empty" {
            posterURL = URL.emptyImage
        } else {
            posterURL = URL.imageBaseURL + item.poster
        }
        
        if let url = URL(string: posterURL) {
            posterImageView.kf.setImage(with: url)
        }
    }
}

extension TVCollectionViewCell: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
