//
//  Constants.swift
//  SeSAC_Talk
//
//  Created by hoon on 1/3/24.
//

import UIKit

enum Constants {

    enum Color {
        enum Brand {
            static let Green = UIColor(hexString: "#4AC645")
            static let Error = UIColor(hexString: "#E9666B")
            static let Inactive = UIColor(hexString: "#AAAAAA")
            static let Black = UIColor(hexString: "#000000")
            static let Gray = UIColor(hexString: "#DDDDDD")
            static let White = UIColor(hexString: "#FFFFFF")
        }
        
        enum Text {
            static let Primary = UIColor(hexString: "#1C1C1C")
            static let Secondary = UIColor(hexString: "#606060")
        }
        
        enum Background {
            static let Primary = UIColor(hexString: "#F6F6F6")
            static let Secondary = UIColor(hexString: "#FFFFFF")
        }
        
        enum View {
            static let Seperator = UIColor(hexString: "#ECECEC")
            static let Alpha = UIColor(hexString: "#00000080")
        }
    }
    
    enum Typography {
        static let Title1 = UIFont.systemFont(ofSize: 22, weight: .bold)
        static let Title2 = UIFont.systemFont(ofSize: 14, weight: .bold)
        static let Bodybold = UIFont.systemFont(ofSize: 13, weight: .bold)
        static let Body = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let Caption = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    enum Image {
        static let onBoardingImage: UIImage = .onboarding
    }
    
//    enum Icon {
//        static let NewMessageButton =
//        
//        enum TabItem {
//            static let home =
//        }
//        
//        enum Chevron {
//            
//        }
//        
//
//    }
    
}
