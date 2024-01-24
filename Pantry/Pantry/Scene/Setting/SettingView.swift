//
//  SettingView.swift
//  Pantry
//
//  Created by hoon on 12/18/23.
//

import UIKit
import Then
import SnapKit

final class SettingView: BaseView {
    
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell().description)
        $0.backgroundColor = .clear
    }
    
    
    override func configureView() {
        addSubview(tableView)
    }
    
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
