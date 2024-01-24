//
//  SetPersonalTableViewCell.swift
//  SeSACgram
//
//  Created by hoon on 11/29/23.
//

import UIKit
import SnapKit
import Then


final class SetPersonalTableViewCell: BaseTableViewCell {
    
    var iconImage = UIImageView().then {
        $0.tintColor = Constants.Color.AppearanceObject
    }
    let title = UILabel().then {
        $0.font = Constants.Font.TypicalFont
    }
    let arrow = UIImageView().then {
        $0.tintColor = UIColor.lightGray
        $0.image = Constants.Image.Arroaw
    }
    lazy var stackView = UIStackView(arrangedSubviews: [iconImage, title]).then {
        $0.axis = .horizontal
        $0.spacing = 20
    }
    
    override var description: String {
        return String(describing: Self.self)
    }
    
    override func configureView() {
        contentView.addSubview(stackView)
        contentView.addSubview(arrow)
    }
    
    
    override func setConstraints() {
        iconImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.size.equalTo(contentView.snp.height).multipliedBy(0.8)
        }
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalTo(arrow.snp.leading).offset(12)
        }
        arrow.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.4)
            $0.width.equalTo(arrow.snp.height).multipliedBy(0.6)
        }
    }
    
    func setCell(data: SetPersonalItem) {
        self.iconImage.image = UIImage(systemName: data.imageName ?? "")
        if data.imageName == nil {
            iconImage.isHidden = true
        }
        if data.title == Menu.Setpersonal.withdraw.rawValue {
            title.textColor = Constants.Color.Red
        } else {
            title.textColor = Constants.Color.AppearanceObject
        }
        self.title.text = data.title
    }
}
