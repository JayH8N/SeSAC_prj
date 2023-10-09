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
    
    
    override func configureView() {
        super.configureView()
        addSubview(blurEffect)
    }
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

