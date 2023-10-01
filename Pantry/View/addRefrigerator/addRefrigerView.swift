//
//  addRefrigerView.swift
//  Pantry
//
//  Created by hoon on 2023/09/28.
//

import UIKit
import SnapKit
import Then

class addRefrigerView: BaseView {
    
    //MARK: - Properties
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
    }
    
    
    
    override func configureView() {
        addSubview(blurEffect)
        addSubview(tableView)
    }
    
    override func setConstraints() {
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
    
}
