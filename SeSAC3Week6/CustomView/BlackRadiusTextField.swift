//
//  BlackRadiusTextField.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/24.
//

import UIKit


class BlackRadiusTextField: UITextField {
    

    
    //Interface Builder를 사용하지 않고, UIView를 상속받은 Custom Class를 코드로 구성할 때 사용되는 초기화 구문
    override init(frame: CGRect) { //UIview
        super.init(frame: frame)
        setupView()
    }
    
    
    
    
    //NSCoding
    //XIB -> NIB변환 과정에서 객체 생성 시 필요한 init구문 (storyboard)
    //Interface Builder에서 생성된 뷰들이 초기화될 때 실행되는 구문!
    required init?(coder: NSCoder) { //NSCoding
        fatalError("init(coder:) has not been implemented")
        
        //코드베이스로 구성하더라도 프로토콜로 정의된(required) 생서자메서드라 실행은 되지 않더라고 기입해줘야 된다.
    }
    
    
    
    
    
    
    func setupView() {
        borderStyle = .none
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        textColor = .black
        textAlignment = .center
        font = .boldSystemFont(ofSize: 15)
    }
    
}

protocol ExampleProtocol {
    init(name: String)
}


class Mobile: ExampleProtocol {
    required init(name: String) { //required : 프로토콜에서 생성된 경우 사용하는 키워드
        
    }
}
