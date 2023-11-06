//
//  SearchViewTableViewCell.swift
//  App_Store
//
//  Created by hoon on 11/6/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class SearchViewTableViewCell: BaseTableViewCell {
    
    var disposeBag = DisposeBag()
    
//MARK: - Properties
    let appIconImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let appNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    let downloadButton = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.setTitleColor(UIColor.systemBlue, for: .normal)
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 15
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    override func configureView() {
        self.selectionStyle = .none
        
        contentView.addSubview(appIconImage)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(downloadButton)
    }
    
    override func setConstraints() {
        appIconImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appIconImage)
            $0.leading.equalTo(appIconImage.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appIconImage)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
    }
    
}
