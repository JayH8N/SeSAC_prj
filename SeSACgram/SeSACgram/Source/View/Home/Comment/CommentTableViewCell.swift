//
//  CommentTableViewCell.swift
//  SeSACgram
//
//  Created by hoon on 12/4/23.
//

import UIKit
import SnapKit
import Then

final class CommentTableViewCell: BaseTableViewCell {
    
    private let profileImage = ProfileImage(frame: .zero)
    
    private let nickName = UILabel().then {
        $0.text = "Nickname"
        $0.font = Constants.Font.HomeNickname
    }
    
    private let comment = UILabel().then {
        $0.font = Constants.Font.BodySize
        $0.numberOfLines = 0
    }
    
    override var description: String {
        return String(describing: Self.self)
    }
    
    override func configureView() {
        self.selectionStyle = .none
        contentView.addSubview(profileImage)
        contentView.addSubview(nickName)
        contentView.addSubview(comment)
    }
    
    override func setConstraints() {
        profileImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(25)
            $0.size.equalTo(30)
        }
        nickName.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.top)
            $0.leading.equalTo(profileImage.snp.trailing).offset(15)
        }
        comment.snp.makeConstraints {
            $0.top.equalTo(nickName.snp.bottom).offset(7)
            $0.leading.equalTo(nickName)
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(25)
        }
    }
    
    func setCell(data: Test) {
        self.nickName.text = data.nickName
        self.comment.text = data.comment
    }
    
    
}
