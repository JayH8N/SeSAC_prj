//
//  MainView.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit
import Then
import SnapKit
import RealmSwift


class MainView: BaseView {
    
    let repository = RefrigeratorRepository()
    
    var stored: Results<Refrigerator>!
//MARK: - Properties
    //blur
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        
    //냉장고 추가버튼
    let addButton = UIButton.makeHighlightedButton(withImageName: "plus")
    
    lazy var refrigerCollection = UICollectionView(frame: .zero, collectionViewLayout: mainCollectionViewLayout()).then {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear//.white.withAlphaComponent(0.5)
        $0.showsHorizontalScrollIndicator = false
        $0.register(RefrigerCell.self, forCellWithReuseIdentifier: RefrigerCell.identifier)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 10
        $0.layer.shadowOpacity = 0.5
    }

//MARK: - Setting
    override func configureView() {
        super.configureView()
        addSubview(blurEffect)
        addSubview(refrigerCollection)
    }
    
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        addButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        refrigerCollection.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
    }
}


//layout
extension MainView {
    func mainCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let size = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: size * 0.5, height: size * 0.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        return layout
    }
}

extension MainView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        return stored.count
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RefrigerCell.identifier, for: indexPath) as! RefrigerCell
        
//        let stored = self.stored[indexPath.item]
//
//        cell.setData(data: stored)
        
        return cell
    }
    
    
}
