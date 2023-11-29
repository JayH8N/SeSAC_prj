//
//  ProfileView.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {
    
    let nickNameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = Constants.Font.NickNameFont
        $0.textColor = Constants.Color.DeepGreen
    }
    
    let menuButton = UIButton.makeHighlightedButton(withImageName: "line.3.horizontal", size: 30)
    
    let modalBackView = UIView().then {
        $0.backgroundColor = UIColor.black
        $0.alpha = 0
    }
    
    override func configureView() {
        //self.backgroundColor = .clear
    }
    
    override func setConstraints() {
        menuButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
    }
    
    func setModalBackView() {
        addSubview(modalBackView)
        modalBackView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }
    
    
    
}
