//
//  CustomTableViewCell.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/25.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    let label = UILabel()
    let button = UIButton()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure() //정적인 디자인 호출
        setConstraints() //제약조건 (addSubView이후에 설정)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        contentView.addSubview(label)  //❗️view.addSubView 오류남
        contentView.addSubview(button)
        label.backgroundColor = .yellow
        button.backgroundColor = .green
    }
    
    func setConstraints() {
        button.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.trailingMargin.equalTo(contentView)
        }
        label.snp.makeConstraints { make in
            make.top.leadingMargin.bottom.equalTo(contentView)
            make.trailing.equalTo(button.snp.leading).inset(8)
        }
        
    }
    
    
    
    
    
    
    
    
    //Interface Builder
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
