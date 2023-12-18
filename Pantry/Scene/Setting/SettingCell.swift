//
//  SettingCell.swift
//  Pantry
//
//  Created by hoon on 12/18/23.
//

import UIKit
import SnapKit
import Then

final class SettingCell: BaseTableViewCell {
    
    private let title = UILabel().then {
        $0.font = Constants.Font.typical
    }
    
    private let arrow = UIImageView().then {
        $0.image = Constants.Image.Arrow
        $0.tintColor = UIColor.gray
    }
    
    private let versionLabel = UILabel().then {
        $0.font = Constants.Font.typical
        $0.textColor = UIColor.gray
    }
    
    override var description: String {
        return String(describing: Self.self)
    }
    
    override func configureView() {
        contentView.addSubview(title)
        contentView.addSubview(arrow)
    }
    
    override func setConstraints() {
        self.backgroundColor = .clear
        title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        arrow.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.4)
            $0.width.equalTo(arrow.snp.height).multipliedBy(0.6)
        }
    }
    
    private func setVersionCell() {
        contentView.addSubview(versionLabel)
        arrow.isHidden = true
        versionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionLabel.text = appVersion
        } else {
            print("앱 버전을 가져올 수 없습니다.")
        }
        
    }
    
    func setCell(data: SettingItem) {
        if data.title == NSLocalizedString(SettingMenu.MenuList.appVersion.rawValue, comment: "") {
            setVersionCell()
        } else {
            arrow.isHidden = false
        }
        
        self.title.text = data.title
    }
}
