//
//  CommentView.swift
//  SeSACgram
//
//  Created by hoon on 12/4/23.
//

import UIKit
import SnapKit

final class CommentView: BaseView {
    
    lazy var commentTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell().description)
        $0.backgroundColor = .clear
        $0.estimatedRowHeight = 80
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
        $0.refreshControl = refresh
    }
    
    let refresh = UIRefreshControl().then {
        $0.backgroundColor = .clear
    }
    
    let tabBackView = UIView().then {
        $0.backgroundColor = Constants.Color.AppearanceModal
        $0.isUserInteractionEnabled = true
    }
    
    let commentTextField = CommentTextField(frame: .zero)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tabBackView.layer.addBorder([.top], width: 0.3, color: Constants.Color.DeepGreen.cgColor)
    }
    
    override func configureView() {
        self.backgroundColor = Constants.Color.AppearanceModal
        addSubview(commentTableView)
        addSubview(tabBackView)
        tabBackView.addSubview(commentTextField)
    }
    
    override func setConstraints() {
        commentTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(tabBackView.snp.top)
        }
        
        tabBackView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        commentTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.9)
            $0.horizontalEdges.equalToSuperview().inset(34)
            $0.height.equalTo(Constants.Frame.commentTextFieldHeight)
        }
    }
}
