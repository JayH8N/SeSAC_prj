//
//  CustomTableViewCell.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/07/28.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    @IBOutlet var backView: UIView!
    @IBOutlet var checkBoxImageView: UIImageView!
    
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    func configureCell(row: ToDo) {
        mainTitleLabel.text = row.main
        subTitleLabel.text = row.sub
        
        func image() -> String {
            if row.done {
                return "checkmark.square.fill"
            } else {
                return "checkmark.square"
            }
        }
        
        func image2() -> String {
            if row.like {
                return "star.fill"
            } else {
                return "star"
            }
        }
        checkBoxImageView.image = UIImage(systemName: image())
        likeButton.setImage(UIImage(systemName: image2()), for: .normal)
    }
    
    
    
    
    
}
