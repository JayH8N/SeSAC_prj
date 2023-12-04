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
    
    weak var presentDelegate: ModalDelegate?
    
    private let profileBackView = UIView().then {
        $0.backgroundColor = Constants.Color.Appearance
    }
    
    private let profileImage = ProfileImage(frame: .zero)
    private let profileNickname = UILabel().then {
        $0.font = Constants.Font.HomeNickname
        $0.text = "Nickname"
    }
    
    private lazy var imageCellCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.backgroundColor = .gray
    }
    
    private let pageControl = UIPageControl().then {
        $0.currentPage = 0
        $0.numberOfPages = 5//imageNames.count
        $0.pageIndicatorTintColor = .lightGray // 페이지를 암시하는 동그란 점의 색상
        $0.currentPageIndicatorTintColor = Constants.Color.LightGreen
    }
    
    private let titleBackView = UIView().then {
        $0.backgroundColor = Constants.Color.Appearance
        $0.isUserInteractionEnabled = true
    }
    
    private let likedButton = LikedButton()
    
    
    private let title = UILabel().then {
        $0.text = "제목입니다."
        $0.font = Constants.Font.HomeNickname
    }
    
    private let contentText = UILabel().then {
        $0.text = "testTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestTexttestText"
        $0.numberOfLines = 0
        $0.font = Constants.Font.BodySize
    }
    
    private let commentButton = UILabel().then {
        let attributedString = NSAttributedString(string: "댓글 보기",
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        $0.attributedText = attributedString
        $0.textColor = UIColor.lightGray
        $0.font = Constants.Font.BodySize
        $0.isUserInteractionEnabled = true
    }
    
    override var description: String {
        return String(describing: Self.self)
    }
    
    override func configureView() {
        tapGeusture()
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
        titleBackView.addSubview(pageControl)
        titleBackView.addSubview(title)
        titleBackView.addSubview(contentText)
        titleBackView.addSubview(commentButton)
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
            $0.top.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(titleBackView.snp.height).multipliedBy(0.25)
        }
        pageControl.snp.makeConstraints {
            $0.top.equalTo(likedButton)
            $0.centerX.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(likedButton.snp.bottom).offset(5)
            $0.leading.equalTo(likedButton)
        }
        
        contentText.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(0)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.33)
        }
        commentButton.snp.makeConstraints {
            $0.top.equalTo(contentText.snp.bottom).offset(2)
            $0.leading.equalTo(likedButton)
        }
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        return layout
    }


}

extension HomeCell {
    private func tapGeusture() {
        let comment = UITapGestureRecognizer(target: self, action: #selector(commentButtonTapped))
        commentButton.addGestureRecognizer(comment)
    }
    
    @objc private func commentButtonTapped() {
        self.presentDelegate?.presnet?()
    }
}
