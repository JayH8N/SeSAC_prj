//
//  ScreenshotCell.swift
//  App_Store
//
//  Created by hoon on 11/8/23.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import Kingfisher


class ScreenshotCell: BaseCollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    let imageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureView() {
        contentView.addSubview(imageView)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
    }
    
    func setCell(url: String) {
        let size = UIScreen.main.bounds.width
        if let url = URL(string: url) {
            imageView.kf.setImage(with: url,options: [.processor(ResizingImageProcessor(referenceSize: CGSize(width: size / 3.5, height: (size / 4) * 1.7)))])
        }
    }
    
    
}

