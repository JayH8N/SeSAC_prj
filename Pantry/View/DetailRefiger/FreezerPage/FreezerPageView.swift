//
//  FreezerPageView.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import Then
import SnapKit

class FreezerPageView: BaseView {
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    lazy var allCollectionView = UICollectionView(frame: .zero, collectionViewLayout: allCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(ItemsCell.self, forCellWithReuseIdentifier: ItemsCell.identifier)
    }
    
    let filterButton = UIButton.makeHighlightedButton(withImageName: "slider.horizontal.3", size: 34).then {
        $0.tintColor = .black
    }
    
    let bgView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0
    }
    
    override func configureView() {
        super.configureView()
        addSubview(blurEffect)
        addSubview(filterButton)
        addSubview(allCollectionView)
    }
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        filterButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(4)
            $0.leading.equalTo(self.snp.leading).inset(18)
        }
        
        allCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterButton.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
}

extension FreezerPageView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCell.identifier, for: indexPath) as! ItemsCell
        
        return cell
    }
}
