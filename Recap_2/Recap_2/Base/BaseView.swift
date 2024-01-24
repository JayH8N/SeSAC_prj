//
//  BaseView.swift
//  Recap_2
//
//  Created by hoon on 2023/09/07.
//

import UIKit


class BaseView: UIView {
    
    let filterCollectionView = {
        let view = UICollectionView()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() { }
    
    func setConstraints() { }
    
    func filterCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        return layout
    }
    
    func resultsCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return layout
    }
    
    func resultsLikeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        let size = UIScreen.main.bounds.width - 44
        layout.itemSize = CGSize(width: size / 2, height: (size / 2) * 1.43)
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return layout
    }
    
    
    func removeTag(_ title: String) -> String {
        return title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
    }

    
    func setButtonImage(button: UIButton, size: CGFloat, systemName: String) {
        let buttonImage = UIImage.SymbolConfiguration(pointSize: size, weight: .light, scale: .small)
        let image = UIImage(systemName: systemName, withConfiguration: buttonImage)
        button.setImage(image, for: .normal)
    }
    
}

