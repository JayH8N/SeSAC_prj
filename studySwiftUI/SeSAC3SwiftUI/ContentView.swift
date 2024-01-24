//
//  ContentView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/13/23.
//

import SwiftUI
//Generic: 사용할 때 타입을 구체적으로 지정
//some: Opaque type (5.1) 역제네릭 타입


//💡1.modifier
//💡2.뷰가 매번 반환된다.
//💡3.modifier 순서

struct ContentView: View {
    
    let a: Array<String> = Array<String>()
    let b: Array<Int> = [2, 3, 4]
    
    var body: some View {
        
//        Button("클릭하기") {
//            let value = type(of: self.body)
//            print(value)
//        }
//        .foregroundStyle(.yellow)
//        .background(.green)
        
        VStack {
            Text("안녕하세요")
                .foregroundStyle(Color.white) //modifier메서드
                .font(.largeTitle)
                .background(Color.black)
                .padding()
                .background(Color.red)
            .border(.green, width: 10)
            
            Text("안녕하세요")
                .foregroundStyle(Color.white) //modifier메서드
                .font(.largeTitle)
                .background(Color.black)
                .padding()
                .background(Color.red)
                .border(.green, width: 10)
        }
        

        
    }
}

#Preview {
    ContentView()
}

//Text("안녕하세요")
//    .foregroundStyle(Color.white) //modifier메서드
//    .font(.largeTitle)
//    .background(Color.black)
//    .padding()
//    .background(Color.red)
//    

//        Text("안녕하세요")
//            .foregroundStyle(Color.white) //modifier메서드
//            .font(.largeTitle)
//            .background(Color.black)
//            .padding()
//            .background(Color.red)
