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
    
    var data: Refrigerator?

    weak var switchDelegate: SwitchScreenProtocol?
    
//MARK: - Properties
    let editButton = UIButton.makeHighlightedButton(withImageName: "ellipsis.circle", size: 40)
    
    let edit = NSLocalizedString("Edit", comment: "")
    let delete = NSLocalizedString("Delete", comment: "")
    
    let image = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .black
        $0.layer.masksToBounds = true
    }
    
    let title = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 23)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
        
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func configureView() {
        contentView.backgroundColor = UIColor.refrigerCellBackground
        contentView.layer.cornerRadius = 15
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(editButton)
    }
    
    
    private func setConstraints() {
//        image.snp.makeConstraints {
//            $0.size.equalTo(self.snp.width).multipliedBy(0.5)
//            $0.leading.equalTo(self.snp.leading).inset(10)
//            $0.top.equalTo(self.snp.top).inset(10)
//        }
        
        image.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(10)
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.size.equalTo(contentView.snp.width).multipliedBy(0.5)
        }

        title.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(10)
            $0.leading.equalTo(image.snp.leading)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.trailing.equalTo(-10)
        }
    }
    
    
    func setData(data: Refrigerator) {
        image.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
        title.text = data.name
    }
    

    
}

extension RefrigerCell {
    
    @objc func editButtonTapped() {
        
        let vc = EditRefrigerViewController()
        vc.data = self.data
        
        let nav = UINavigationController(rootViewController: vc)
        
        switchDelegate?.switchScreen(nav: nav)
    }
    
}
