//
//  ProfileImage.swift
//  SeSACgram
//
//  Created by hoon on 12/3/23.
//

import UIKit

final class ProfileImage: UIImageView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        layer.borderWidth = 2.5
        layer.borderColor = Constants.Color.LightGreen.cgColor
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = self.bounds.width / 2
    }
    
}
