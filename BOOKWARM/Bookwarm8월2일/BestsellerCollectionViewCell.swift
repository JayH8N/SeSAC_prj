//
//  BestsellerCollectionViewCell.swift
//  BOOKWARM
//
//  Created by hoon on 2023/08/02.
//

import UIKit

class BestsellerCollectionViewCell: UICollectionViewCell {

    static let idenifier = "BestsellerCollectionViewCell"
    
    @IBOutlet var bookCover: UIImageView!
    
    // prepareForReuse
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookCover.layer.shadowColor = UIColor.black.cgColor   //그림자 색깔
        bookCover.layer.shadowOffset = CGSize(width: 0, height: 0)  //태양이 보는 시점
        bookCover.layer.shadowRadius = 10  //그림자 코너깎임정도
        bookCover.layer.shadowOpacity = 0.5   //그림자 투명도

    }

    
  func setCell(item: Book) {
    bookCover.image = UIImage(named: item.image)
  }
    
    
    
    
    
}
