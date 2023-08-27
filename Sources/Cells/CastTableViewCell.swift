//
//  CastTableViewCell.swift
//  Media
//
//  Created by hoon on 2023/08/20.
//

import UIKit
import Kingfisher

class CastTableViewCell: UITableViewCell {

    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setDesignCell()
    }
    
    func setDesignCell() {
        profileImage.layer.cornerRadius = 10
        profileImage.contentMode = .scaleToFill
        nameLabel.font = .boldSystemFont(ofSize: 14)
        characterLabel.font = .systemFont(ofSize: 12)
        characterLabel.textColor = .lightGray
    }
    
    
    func setCell(row: CastInfo) {
        let imageURL = "https://image.tmdb.org/t/p/w500"
        
        nameLabel.text = row.name
        characterLabel.text = row.character
        if let url = URL(string: imageURL + row.image) {
            profileImage.kf.setImage(with: url)
        }
    }
    
    

    

}

extension CastTableViewCell: Reusableidentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
