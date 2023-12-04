//
//  HomeView.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit
import Then
import SnapKit

final class HomeView: BaseView {
    
    let appNameLabel = UILabel().then {
        $0.text = "SeSACgram"
        $0.font = Constants.Font.HomeTitle
        $0.textColor = Constants.Color.DeepGreen
    }
    
    let refresh = UIRefreshControl().then {
        $0.backgroundColor = .clear
        $0.attributedTitle = NSAttributedString(string: "Loading Data...",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
    }
    
    lazy var homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell().description)
        $0.refreshControl = refresh
    }
    
    
  
    
    override func configureView() {
        addSubview(homeCollectionView)
    }
    
    override func setConstraints() {
        homeCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    
}
