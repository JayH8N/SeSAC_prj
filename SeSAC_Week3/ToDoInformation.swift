//
//  ToDoInformation.swift
//  SeSAC_Week3
//
//  Created by hoon on 2023/07/28.
//

import UIKit

struct ToDoInformation {
    
    //랜덤컬러
    static func randomBackgroundColor() -> UIColor { //인스턴스 메서드
        
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    
    //인스턴스 프로퍼티
    var list = [ToDo(main: "장보기", sub: "23.07.03", like: false, done: true, color: randomBackgroundColor()),
                ToDo(main: "영화보기", sub: "23.07.30", like: true, done: false, color: randomBackgroundColor()),
                ToDo(main: "장보기", sub: "23.08.13", like: false, done: false, color: randomBackgroundColor())]
    
    
    
    //함수를 사용하지 못한다. 인스턴스 메서드, 인스턴스 프로퍼티이기에 동시에 초기화가 되기에 함수사용을 못한다. 그래서 static으로 메서드앞에 선언해줘서 사용해야된다.

}
