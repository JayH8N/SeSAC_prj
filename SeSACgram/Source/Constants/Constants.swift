//
//  Constants.swift
//  SeSACgram
//
//  Created by hoon on 11/14/23.
//

import UIKit

enum Constants {
    
    enum Color {
        static let LightGreen = UIColor(red: 87/255, green: 128/255, blue: 35/255, alpha: 1)
        static let DeepGreen = UIColor(red: 35/255, green: 85/255, blue: 19/255, alpha: 1)
        static let Appearance = UIColor(named: "AppearanceColor")
    }
    
    enum Image {
        static let TabBarHome = "Home"
        static let TabBarSearch = "Search"
        static let TabBarProfile = "Profile"
        static let SeSAC_Logo = "SeSAC_LaunchScreen"
        static let Xmark = UIImage(systemName: "xmark")
        static let OpenEye = UIImage(systemName: "eye")
        static let CloseEye = UIImage(systemName: "eye.slash")
    }
    
    enum Font {
        static let HeaderTitle: UIFont = .systemFont(ofSize: 28, weight: .bold)
        static let HeaderSubTitle: UIFont = .systemFont(ofSize: 15, weight: .thin)
        static let BodySize: UIFont = .systemFont(ofSize: 13, weight: .regular)
        static let themeFont = UIFont(name: "omyu pretty", size: 22)
    }
    
    enum Size {
        static let buttonCornerRadius: CGFloat = 22
        static let textFieldCornerRadius: CGFloat = 10
    }
    
    enum Frame {
        static let textFieldHeight: Int = 54
        static let buttonHeight: Int = 44
    }
    
    
}
