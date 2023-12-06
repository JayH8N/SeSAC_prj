//
//  TestPostView.swift
//  SeSACgram
//
//  Created by hoon on 12/6/23.
//

import UIKit
import SnapKit
import Then

final class TestPostView: BaseView {
    private let size = UIScreen.main.bounds.width / 4
    
    lazy var imagePickerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.backgroundColor = .clear
        $0.register(ImagePickerCell.self, forCellWithReuseIdentifier: ImagePickerCell().description)
        //$0.register(AddedImageCell.self, forCellWithReuseIdentifier: AddedImageCell().description)
        $0.showsHorizontalScrollIndicator = false
    }
    
    override func configureView() {
        addSubview(imagePickerCollectionView)
    }
    
    
    override func setConstraints() {
        imagePickerCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(self.size + 32)
        }
    }
    
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: size, height: size)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 24, bottom: 12, right: 0)
        return layout
    }
}
