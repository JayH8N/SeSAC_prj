//
//  ProfileHeaderView.swift
//  SeSACgram
//
//  Created by hoon on 12/13/23.
//

import UIKit
import Then
import SnapKit

final class ProfileHeaderView: BaseView {
    
    let profile = ProfileImage(frame: .zero).then {
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .gray
    }
    
    let profileEditButton = UIButton().then {
        $0.setBackgroundColor(UIColor.lightGray, for: .normal)
        $0.setTitle("프로필 편집", for: .normal)
        $0.titleLabel?.font = Constants.Font.TypicalFont
    }
    
    let postCount = ProfileStackView(title: "게시물")
    let follower = ProfileStackView(title: "팔로워")
    let following = ProfileStackView(title: "팔로잉")
    
    lazy var stackView = UIStackView(arrangedSubviews: [postCount, follower, following]).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileEditButton.layer.cornerRadius = 10
        profileEditButton.layer.masksToBounds = true
    }
    
    override func configureView() {
        self.backgroundColor = .clear
        addSubview(profile)
        addSubview(profileEditButton)
        addSubview(stackView)
    }
    
    override func setConstraints() {
        profile.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.8)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(self.snp.height).multipliedBy(0.5)
        }
        
        profileEditButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.equalTo(32)
            $0.bottom.equalToSuperview().inset(14)
        }
        
        stackView.snp.makeConstraints {
            $0.centerY.equalTo(profile)
            $0.leading.equalTo(profile.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(profile.snp.height).multipliedBy(0.5)
        }
    }
    
}
