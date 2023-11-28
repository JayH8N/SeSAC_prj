//
//  HomeView.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit
import Then
import SnapKit

final class HomeView: BaseView {
    
    let appNameLabel = UILabel().then {
        $0.text = "SeSACgram"
        $0.font = Constants.Font.HomeTitle
        $0.textColor = Constants.Color.DeepGreen
    }
  
    
    override func configureView() {
        
    }
    
    override func setConstraints() {
        
    }
    
    
}
