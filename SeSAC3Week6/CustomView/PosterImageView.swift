//
//  PosterImageView.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/25.
//

import UIKit


class PosterImagerView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        backgroundColor = .yellow
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        clipsToBounds = true

    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubView", frame.width, frame)
        layer.cornerRadius = frame.width / 2
    }
    
    
}
