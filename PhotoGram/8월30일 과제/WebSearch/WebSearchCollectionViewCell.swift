//
//  WebSearchCollectionViewCell.swift
//  Diary
//
//  Created by hoon on 2023/08/30.
//

import UIKit

class WebSearchCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(imageView)
    }
    
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    
}

extension WebSearchCollectionViewCell: ReusableIdentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
