//
//  AddedImageCell.swift
//  SeSACgram
//
//  Created by hoon on 12/1/23.
//

import UIKit
import SnapKit
import SnapKit

class AddedImageCell: BaseCollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let removeButton = UIButton.makeHighlightedButton(withImageName: "xmark.circle.fill", size: 30)
    
    override var description: String {
        String(describing: Self.self)
    }
    
    private func setLayer() {
        layer.cornerRadius = Constants.Size.cellCornerRadius
        layer.borderWidth = 3
        layer.borderColor = Constants.Color.DeepGreen.cgColor
    }
    
    override func configureView() {
        setLayer()
        contentView.addSubview(imageView)
        contentView.addSubview(removeButton)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        removeButton.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).inset(-10)
            $0.trailing.equalTo(self.snp.trailing).inset(-10)
        }
    }
    
    func setImage() {
        //이미지 삽입 로직
    }
    
}
