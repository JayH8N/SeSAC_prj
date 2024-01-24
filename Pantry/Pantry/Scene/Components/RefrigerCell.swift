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
    
    let repository = RefrigeratorRepository()
    
    var data: Refrigerator?

    weak var switchDelegate: SwitchScreenProtocol?
    
//MARK: - Properties
    //let editButton = UIButton.makeHighlightedButton(withImageName: "ellipsis", size: 38)
    let editButton = UIButton.makeHighlightedButton2(withImageName: "ellipsis")
    
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
    
    let refrigerIcon = UIImageView().then {
        $0.image = UIImage(systemName: "thermometer.snowflake")
        $0.tintColor = .black
    }
    let refrigerItemNumber = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.text = "TestTest"
    }
    let frozenIcon = UIImageView().then {
        $0.image = UIImage(systemName: "snowflake")
        $0.tintColor = .black
    }
    let frozenItemNumber = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.text = "TestTest"
    }
    lazy var refrigerStackView = UIStackView(arrangedSubviews: [refrigerIcon, refrigerItemNumber]).then {
        $0.axis = .horizontal
        $0.spacing = 6
    }
    lazy var frozenStackView = UIStackView(arrangedSubviews: [frozenIcon, frozenItemNumber]).then {
        $0.axis = .horizontal
        $0.spacing = 6
    }
    lazy var ItemCountStackView = UIStackView(arrangedSubviews: [refrigerStackView, frozenStackView]).then {
        $0.axis = .vertical
        $0.spacing = 7
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
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        contentView.layer.cornerRadius = 15
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(editButton)
        contentView.addSubview(ItemCountStackView)
    }
    
    
    private func setConstraints() {
        
        image.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(10)
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.size.equalTo(contentView.snp.width).multipliedBy(0.5)
        }

        title.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(17)
            $0.leading.equalTo(image.snp.leading)
            $0.trailing.equalTo(-10)
        }
        
        editButton.snp.makeConstraints {
            $0.size.equalTo(23)
            $0.top.equalTo(13)
            $0.trailing.equalTo(-8)
        }
        
        refrigerIcon.snp.makeConstraints {
            $0.size.equalTo(editButton)
        }
        
        frozenIcon.snp.makeConstraints {
            $0.size.equalTo(editButton)
        }
        
        
        ItemCountStackView.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(10)
            $0.trailing.equalTo(contentView.snp.trailing).inset(10)
            $0.height.equalTo(refrigerIcon.snp.height).multipliedBy(2.3)
            $0.bottom.equalTo(image.snp.bottom)
        }
    }
    
    
    func setData(data: Refrigerator) {
        image.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
        title.text = data.name
        
        let refrigerItemCount = repository.itemCountForState(in: data._id, state: State.refrigeration)
        let frozenItemCount = repository.itemCountForState(in: data._id, state: State.frozen)
        refrigerItemNumber.text = " :  \(refrigerItemCount)"
        frozenItemNumber.text = " :  \(frozenItemCount)"
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
