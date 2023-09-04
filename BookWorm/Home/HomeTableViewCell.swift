//
//  HomeTableViewCell.swift
//  BookWorm
//
//  Created by hoon on 2023/09/04.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    
    let image = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 3
        view.layer.shadowColor = UIColor.red.cgColor   //그림자 색깔
        view.layer.shadowOffset = CGSize(width: 0, height: 0)  //태양이 보는 시점
        view.layer.shadowRadius = 10  //그림자 코너깎임정도
        view.layer.shadowOpacity = 1   //그림자 투명도
        return view
        }()
    
    let title = {
        let view = UILabel()
        view.text = "제목"
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let author = {
        let view = UILabel()
        view.text = "작가"
        view.textColor = .systemPink
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureView() {
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(author)
    }
    
    
    private func setConstraints() {
        image.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.2)
            make.height.equalTo(image.snp.width).multipliedBy(1.2)
            make.leading.equalToSuperview().inset(10)
            }
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(20)
            make.top.equalTo(contentView.snp.top).inset(20)
        }
        
        author.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.leading.equalTo(title.snp.leading)
        }
    }

}
