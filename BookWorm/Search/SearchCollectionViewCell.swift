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
        view.clipsToBounds = true
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
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        contentView.addSubview(uiView)
        uiView.addSubview(coverPoster)
        uiView.addSubview(title)
        uiView.addSubview(author)
    }
    
    
    func setConstraints() {
        uiView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coverPoster.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width).multipliedBy(0.8)
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
