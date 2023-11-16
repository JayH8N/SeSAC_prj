//
//  RenderView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/13/23.
//

import SwiftUI

struct RenderView: View {
    //시스템에서 정의된 값을 감지하고 뷰를 업데이트 할 수 있음
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var jack
    @State var age = 10
    
    init(age: Int = 10) {
        self.age = age
        print("RenderView")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.red,
                                                                       Color.black]),
                                           startPoint: .bottomLeading,
                                           endPoint: .trailing)
                        )
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            RadialGradient(gradient: Gradient(colors: [Color.yellow, Color.blue]),
                                           center: .center,
                                           startRadius: 10,
                                           endRadius: 70)
                        )
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            AngularGradient(colors: [.yellow,
                                                     .green],
                                            center: .leading,
                                            angle: .degrees(10))
                        )
                }
                .frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                NavigationLink("Push") {
                    MenuView()
                }
                
                hue
                Text("Jack: \(age) ,\(Int.random(in: 1...100))")
                Text("Bran: \(Int.random(in: 1...100))")
                KokoView()
                Button(jack == .dark ? "다크모드 클릭" : "라이트모드 클릭") {
                    //age = Int.random(in: 1...100)
                    //presentationMode.wrappedValue.dismiss()
                    dismiss.callAsFunction()
                }
                .background(jack == .dark ? .pink : .gray)
                .foregroundStyle(jack == .dark ? .white : .yellow)
            }
            .navigationTitle("네비게이션 타이틀")
            .navigationBarItems(leading: Text("클릭"))
        }
    }
    
    var hue: some View {
        Text("Hue: \(Int.random(in: 1...100))")
    }
    
}

#Preview {
    RenderView()
}



struct KokoView: View {
    var body: some View {
        Text("Koko: \(Int.random(in: 1...100))")
    }
}
