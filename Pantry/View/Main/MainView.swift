//
//  MainView.swift
//  Pantry
//
//  Created by hoon on 2023/09/25.
//

import UIKit
import Then
import SnapKit


class MainView: BaseView {
    
//MARK: - Properties
    //blur
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        
    //냉장고 추가버튼
    let addButton = UIButton.makeHighlightedButton(withImageName: "plus")
    
    
    
    
//MARK: - LifeCycle
    override func configureView() {
        super.configureView()
        self.addSubview(blurEffect)
    }
    
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        addButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
    }
    
}

