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
import FSPagerView

class MainView: BaseView {
    
    let repository = RefrigeratorRepository()
    
    var stored: Results<Refrigerator>!
    
    weak var delegate: didSelectProtocol?
//MARK: - Properties
    //blur
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        
    //냉장고 추가버튼
    let addButton = UIButton.makeHighlightedButton(withImageName: "plus")
    

    
    lazy var refrigerCollection = FSPagerView(frame: .zero).then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(RefrigerCell.self, forCellWithReuseIdentifier: RefrigerCell.identifier)
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 10
        $0.layer.shadowOpacity = 0.5
        let size = UIScreen.main.bounds.width
        $0.itemSize = CGSize(width: size * 0.6, height: size * 0.5)
        $0.interitemSpacing = 20
        $0.transformer = FSPagerViewTransformer(type: .overlap)
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

extension MainView: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 10
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: RefrigerCell.identifier, at: index) as! RefrigerCell
        
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let vc = DetailPagerTabViewController()
        delegate?.didselectItemAt(vc: vc)
    }
    
    
}
