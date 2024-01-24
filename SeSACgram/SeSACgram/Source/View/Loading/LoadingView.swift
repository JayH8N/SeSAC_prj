//
//  LoadingView.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit
import Then
import SnapKit
import NVActivityIndicatorView

final class LoadingView: BaseView {
    
    private let logoImage = UIImageView().then {
        $0.image = Constants.Image.SeSAC_Logo
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "SeSACgram"
        $0.font = Constants.Font.MainTitle
    }
    
    private let subTitleFrom = UILabel().then {
        $0.text = "from"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .light)
    }
    
    private let subTitleName = UILabel().then {
        $0.text = "JungHoon Yoo"
        $0.font = UIFont.systemFont(ofSize: 25, weight: .thin)
    }
    
    let indicator = NVActivityIndicatorView(frame: .init(x: 0, y: 0, width: 100, height: 100),
                                            type: .ballRotateChase,
                                            color: Constants.Color.DeepGreen,
                                            padding: 4)
    
    override func configureView() {
        addSubview(logoImage)
        addSubview(titleLabel)
        addSubview(subTitleFrom)
        addSubview(subTitleName)
        addSubview(indicator)
    }
    
    override func setConstraints() {
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.5)
            $0.width.equalTo(240)
            $0.height.equalTo(logoImage.snp.width).multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImage.snp.bottom)
        }
        
        subTitleFrom.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.74)
        }
        
        subTitleName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subTitleFrom.snp.bottom).offset(5)
        }
        
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
