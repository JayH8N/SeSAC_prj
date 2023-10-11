//
//  AllPageView.swift
//  Pantry
//
//  Created by hoon on 2023/10/09.
//

import UIKit
import Then
import SnapKit
import JJFloatingActionButton

class AllPageView: BaseView {
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    lazy var allCollectionView = UICollectionView(frame: .zero, collectionViewLayout: allCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(ItemsCell.self, forCellWithReuseIdentifier: ItemsCell.identifier)
    }
    
    let addFood = NSLocalizedString("addFood", comment: "")
    let addFoodBarcode = NSLocalizedString("addFoodBarcode", comment: "")
    
    lazy var actionButton = JJFloatingActionButton().then {
        $0.buttonImage = UIImage(systemName: "plus")
        $0.buttonColor = UIColor.black
        
        
        $0.addItem(title: addFood, image: UIImage(systemName: "square")) { _ in
            print("firstButton")
        }
        $0.addItem(title: addFoodBarcode, image: UIImage(systemName: "barcode.viewfinder")) { _ in
            print("SecondButton")
        }
        $0.buttonImageSize = CGSize(width: 40, height: 40)
    }
    
    
    
    override func configureView() {
        super.configureView()
        addSubview(blurEffect)
        addSubview(allCollectionView)
        addSubview(actionButton)
        
    }
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        allCollectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        actionButton.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).inset(30)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(30)
        }
        
    }
    
    
}

extension AllPageView {
    private func allCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        let size = UIScreen.main.bounds.width - 36
        layout.itemSize = CGSize(width: size / 2, height: (size / 2) * 0.7)
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return layout
    }
}

extension AllPageView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCell.identifier, for: indexPath) as! ItemsCell
        
        return cell
    }
    
    
}
