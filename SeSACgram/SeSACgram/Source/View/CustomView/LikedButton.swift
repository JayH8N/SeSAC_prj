//
//  LikedButton.swift
//  SeSACgram
//
//  Created by hoon on 12/3/23.
//

import UIKit
import SnapKit
import Then

final class LikedButton: BaseView {
    
    private var isSelected: Bool = false {
        didSet {
            update()
        }
    }
    
    private let buttonImage = UIImageView().then {
        $0.tintColor = Constants.Color.LightGreen
    }
    
    override func configureView() {
        update()
        self.backgroundColor = .clear
        addSubview(buttonImage)
    }
    
    override func setConstraints() {
        buttonImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(self.snp.width)
        }
    }
    
    private func update() {
        if isSelected {
            buttonImage.image = Constants.Image.HeartFill
        } else {
            buttonImage.image = Constants.Image.Heart
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        HapticManager.shared.viberateForInteraction(style: .light)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected.toggle()
    }
    
}
