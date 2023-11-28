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
        static let AppearanceModal = UIColor(named: "AppearanceModal")
        static let AppearanceObject = UIColor(named: "AppearanceObject")
    }
    
    enum Image {
        static let TabBarHome = "Home"
        static let TabBarSearch = "Search"
        static let TabBarProfile = "Profile"
        static let SeSAC_Logo = UIImage(named: "SeSAC_LaunchScreen")
        static let Xmark = UIImage(systemName: "xmark")
        static let OpenEye = UIImage(systemName: "eye")
        static let CloseEye = UIImage(systemName: "eye.slash")
        static let Gear = "gear"
    }
    
    enum Font {
        static let MainTitle = UIFont(name: "Didot", size: 35)
        static let HomeTitle = UIFont(name: "Didot", size: 30)
        static let HeaderTitle: UIFont = .systemFont(ofSize: 28, weight: .bold)
        static let HeaderSubTitle: UIFont = .systemFont(ofSize: 15, weight: .thin)
        static let BodySize: UIFont = .systemFont(ofSize: 13, weight: .regular)
        static let ButtonFont = UIFont(name: "omyu pretty", size: 22)
        static let NickNameFont = UIFont(name: "omyu pretty", size: 35)
        static let TypicalFont = UIFont(name: "omyu pretty", size: 19)
        static let NavigationTitle = UIFont(name: "omyu pretty", size: 25)
    }
    
    enum Size {
        static let buttonCornerRadius: CGFloat = 22
        static let textFieldCornerRadius: CGFloat = 10
    }
    
    enum Frame {
        static let textFieldHeight: Int = 54
        static let buttonHeight: Int = 44
        static let menuListHeight: Int = 44
    }
    
    
}
