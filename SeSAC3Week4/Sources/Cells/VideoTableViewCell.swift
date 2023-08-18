//
//  VideoTableViewCell.swift
//  SeSAC3Week4
//
//  Created by hoon on 2023/08/09.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    //static let identifier = "VideoTableViewCell"
    
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        contentLabel.numberOfLines = 2
        contentLabel.font = .systemFont(ofSize: 13)
        thumbnailImageView.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
