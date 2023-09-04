//
//  SearchCollectionViewCell.swift
//  BookWorm
//
//  Created by hoon on 2023/09/04.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let uiView = UIView()
    
    let coverPoster = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    let title = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 14)
        return view
    }()
    
    let author = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        //contentView.addSubview(uiView)
        contentView.addSubview(coverPoster)
        contentView.addSubview(title)
        contentView.addSubview(author)
    }
    
    
    func setConstraints() {
//        uiView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        coverPoster.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(coverPoster.snp.width).multipliedBy(1.4)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(coverPoster.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        author.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    
    
    
}
