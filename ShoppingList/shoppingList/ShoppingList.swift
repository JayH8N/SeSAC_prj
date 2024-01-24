//
//  ShoppingListTableViewCell.swift
//  shoppingList
//
//  Created by hoon on 2023/07/28.
//

import UIKit

class ShoppingList: UITableViewCell {
    
    
    @IBOutlet var backView: UIView!
    @IBOutlet var checkBoxButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var mainTitleLabel: UILabel!
    
    func configureCell(row: ItemList) {
        mainTitleLabel.text = row.title
        
        func image() -> String {
            if row.check == true {
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
        backView.backgroundColor = .systemGray4
        checkBoxButton.setImage(UIImage(systemName: image()), for: .normal)
        likeButton.setImage(UIImage(systemName: image2()), for: .normal)
    }
        
    
    
    
}
