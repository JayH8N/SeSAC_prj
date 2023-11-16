//
//  TamagotchiView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/14/23.
//

import SwiftUI

struct User {
    var nickname = "고래밥"
    
    var introduce: String {
        mutating get {
            nickname = "칙촉"
            return "안녕하세요. \(nickname)입니다."
        }
    }
    
    mutating func changeNickname() {
        nickname = "칙촉"
    }
}

//앱에서 UI는 Data에 의존해서 자신의 상태를 결정하게 된다.
//@State Source of Truth. View에 대한 상태를 저장하기 위한 모적.
//상태 프로퍼티(State Property)
//@Binding data == 파생된 데이터
//상위뷰 @State, 하위뷰 @Binding

struct TamagotchiView: View {
    
    //@State private var nickname = "고래밥" //Source of Truth  : nickname값이 변경되면 body를 렌더링시킴
    @State private var riceCount: Int = 0
    @State private var waterCount: Int = 0
    
    @State private var isOn: Bool = false
    @State private var textFieldText: String = "Hello world!"
    
    var body: some View {
        VStack {
            TextField("밥알 갯수 입력하기", text: $textFieldText)
                .background(.yellow)
            Toggle("스위치", isOn: $isOn)
            .padding(100)
            
            CountLabel(title: "밥알", count: $riceCount)
            Button("밥알 갯수") {
                riceCount += 1
                isOn.toggle()
            }
            .padding(30)
            .background(.orange)
            
            CountLabel(title: "물방울", count: $waterCount)
            Button(action: {
                waterCount += 1
                isOn.toggle()
            }, label: {
                VStack {
                    Text("ActionButton")
                    Text("물방울 갯수")
                }
                .padding(50)
                .background(.pink)
            })
        }
    }
}

#Preview {
    TamagotchiView()
}

struct CountLabel: View {
    
    let title: String
    @Binding var count: Int
    
    var body: some View {
        HStack {
            Text("\(title) : \(count)")
                .background(.black)
                .foregroundStyle(.white)
                .font(.largeTitle)
            .clipShape(.capsule)
            Button("하위뷰 버튼") {
                //여기서도 count += 1을 해주고 싶음!
                count += 1
            }
        }
    }
}
