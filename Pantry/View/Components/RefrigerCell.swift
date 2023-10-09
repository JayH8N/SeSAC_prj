//
//  RefrigerCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/04.
//

import UIKit
import Then
import SnapKit
import FSPagerView

class RefrigerCell: FSPagerViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    let image = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
    }
    
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
    }
    

    func configureView() {
        contentView.backgroundColor = UIColor.refrigerCellBackground
        contentView.layer.cornerRadius = 15
        contentView.addSubview(image)
        contentView.addSubview(title)
    }
    
    
    func setConstraints() {
        image.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(self.snp.height).multipliedBy(0.4)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview().inset(5)
        }
    }
    
    
    func setData(data: Refrigerator) {
        image.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
        title.text = data.name
    }
    
    
    
    
    
}
