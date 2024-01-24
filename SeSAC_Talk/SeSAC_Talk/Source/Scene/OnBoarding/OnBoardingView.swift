//
//  OnBoardingView.swift
//  SeSAC_Talk
//
//  Created by hoon on 1/8/24.
//

import UIKit
import Then
import SnapKit

final class OnBoardingView: BaseView {
    
    private let mainText = UILabel().then {
        $0.font = Constants.Typography.Title1
        $0.textAlignment = .center
        $0.text = "새싹톡을 사용하면 어디서나\n팀을 모을 수 있습니다"
        $0.numberOfLines = 2
    }
    
    private let imageView = UIImageView().then {
        $0.image = Constants.Image.onBoardingImage
    }
    
    let startButton = ActionButton(enalble: true, text: "시작하기")
    
    override func configureView() {
        addSubview(mainText)
        addSubview(imageView)
        addSubview(startButton)
    }
    
    override func setConstraints() {
        mainText.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(93)
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(45)
        }
        
    }
    
    
}
