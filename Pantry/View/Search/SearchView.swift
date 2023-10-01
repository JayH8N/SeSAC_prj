//
//  SearchView.swift
//  Pantry
//
//  Created by hoon on 2023/09/27.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
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
