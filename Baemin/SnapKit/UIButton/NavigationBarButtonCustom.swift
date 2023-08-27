//
//  NavigationBarButtonCustom.swift
//  Baemin
//
//  Created by hoon on 2023/08/26.
//

import UIKit


class NavigationBarButtonCustom: UIButton {




    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




    func setView() {
        tintColor = .white
        backgroundColor = .clear
    }






}
