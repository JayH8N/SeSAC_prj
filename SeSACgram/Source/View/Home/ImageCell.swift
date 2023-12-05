//
//  ImageCell.swift
//  SeSACgram
//
//  Created by hoon on 12/5/23.
//

import UIKit
import SnapKit
import SnapKit
import Kingfisher

final class ImageCell: BaseCollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    override var description: String {
        return String(describing: Self.self)
    }
    
    
    override func configureView() {
        contentView.addSubview(imageView)
    }
    
    
    override func setConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setImages(url: String) {
        let size = UIScreen.main.bounds.width
        if let url = URL(string: url) {
            imageView.kf.setImage(with: url,
                                  options: [.processor(ResizingImageProcessor(referenceSize: CGSize(width: size,
                                                                                                    height: size)))])
        }
    }
    
    
    //🔥삭제요망
    func setCell() {
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        
        let randomColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
        imageView.backgroundColor = randomColor
    }
}
