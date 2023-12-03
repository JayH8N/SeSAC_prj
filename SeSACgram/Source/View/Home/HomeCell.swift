//
//  HomeCell.swift
//  SeSACgram
//
//  Created by hoon on 12/3/23.
//

import UIKit
import SnapKit
import Then


final class HomeCell: BaseCollectionViewCell {
    
    private let profileBackView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    private let profileImage = ProfileImage(frame: .zero)
    private let profileNickname = UILabel().then {
        $0.font = Constants.Font.HomeNickname
        $0.text = "Nickname"
    }
    
    private lazy var imageCellCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.backgroundColor = .gray
    }
    
    private let titleBackView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let likedButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    
    private let title = UILabel().then {
        $0.text = "제목입니다."
    }
    
    override var description: String {
        return String(describing: Self.self)
    }
    
    override func configureView() {
        contentView.addSubview(profileBackView)
        contentView.addSubview(imageCellCollectionView)
        contentView.addSubview(titleBackView)
        setProfileBackView()
        setTitleBackView()
    }
    
    private func setProfileBackView() {
        profileBackView.addSubview(profileImage)
        profileBackView.addSubview(profileNickname)
    }
    
    private func setTitleBackView() {
        titleBackView.addSubview(likedButton)
    }
    
    override func setConstraints() {
        profileBackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(imageCellCollectionView.snp.height).multipliedBy(0.16)
        }
        
        profileImage.snp.makeConstraints {
            $0.size.equalTo(profileBackView.snp.height).multipliedBy(0.7)
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        profileNickname.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
        }
        
        imageCellCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(profileBackView.snp.bottom)
            $0.height.equalTo(UIScreen.main.bounds.width)
        }
        
        titleBackView.snp.makeConstraints {
            $0.top.equalTo(imageCellCollectionView.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        
        likedButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        return layout
    }
}
