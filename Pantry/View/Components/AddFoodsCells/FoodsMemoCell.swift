//
//  FoodsMemoCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/14.
//

import UIKit
import SnapKit
import Then

class FoodsMemoCell: BaseTableViewCell {
    
    let memo = NSLocalizedString("Memo", comment: "")
    
    let backUIView = UIView()
    
    lazy var memoLabel = UILabel().then {
        $0.text = memo
        $0.font = .boldSystemFont(ofSize: 17)
    }
    
    let memoTextView = UITextView().then {
        $0.tintColor = .black
        $0.font = .systemFont(ofSize: 17)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        memoTextView.layer.addBorder([.top], width: 0.3, color: UIColor.gray.cgColor)
    }
    
    
    override func configureView() {
        selectionStyle = .none
        contentView.addSubview(backUIView)
        backUIView.addSubview(memoLabel)
        backUIView.addSubview(memoTextView)
    }
    
    override func setConstraints() {
        backUIView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(13)
        }
        
        memoTextView.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    
}
