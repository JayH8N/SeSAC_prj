//
//  SetPersonalView.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit
import SnapKit
import Then

final class SetPersonalView: BaseView {
    
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(SetPersonalTableViewCell.self, forCellReuseIdentifier: SetPersonalTableViewCell().description)
        $0.rowHeight = Constants.Frame.tableViewheight
        $0.backgroundColor = Constants.Color.Appearance
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
