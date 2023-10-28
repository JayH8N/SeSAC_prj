//
//  RefigerPageView.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import Then
import SnapKit
import RealmSwift

class RefigerPageView: BaseView {
    
    var itemList: Results<Items>!

    lazy var allCollectionView = UICollectionView(frame: .zero, collectionViewLayout: allCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(ItemsCell.self, forCellWithReuseIdentifier: ItemsCell.identifier)
    }
    
    let filterButton = UIButton.makeHighlightedButton(withImageName: "slider.horizontal.3", size: 34).then {
        $0.tintColor = .black
    }
    
    let filterLabel = UILabel().then {
        $0.font = UIFont(name: "TAEBAEK milkyway", size: 16)
        $0.text = NSLocalizedString("SortNetAdded", comment: "")
    }
    
    let bgView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0
    }
    
    override func configureView() {
        super.configureView()
        addSubview(filterButton)
        addSubview(allCollectionView)
        addSubview(filterLabel)
    }
    
    
    override func setConstraints() {
        filterButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(self.snp.leading).inset(18)
        }
        
        allCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterButton.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        filterLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(filterButton.snp.top).inset(5)
        }
        
    }
    
}

extension RefigerPageView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCell.identifier, for: indexPath) as! ItemsCell
        
        let data = itemList[indexPath.item]
        cell.setCell(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HapticFeedbackManager.shared.provideFeedback()
        let data = itemList[indexPath.item]
        
        let vc = EditItemViewController()
        vc.data = data
        let nav = UINavigationController(rootViewController: vc)
        
        self.window?.rootViewController?.present(nav, animated: true)
    }
    
    
}
