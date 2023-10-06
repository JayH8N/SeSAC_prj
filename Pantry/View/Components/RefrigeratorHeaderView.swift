//
//  RefrigeratorHeaderView.swift
//  Pantry
//
//  Created by hoon on 2023/10/04.
//

import UIKit
import Then
import SnapKit

class RefrigeratorHeaderView: UICollectionReusableView {
    
    let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(titleLabel)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
