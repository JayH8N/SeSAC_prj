//
//  MovieView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/14/23.
//

import SwiftUI

struct MovieView: View {
    
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            //Color.init(red: 254/255, green: 251/255, blue: 236/255)
            Image("bear")
                .resizable()
                //.scaledToFill()
                .ignoresSafeArea()
            Image("bear")
                .resizable()
                .frame(width: 200, height: 200)
                .border(Color.white, width: 4)
                
            Text("ㅎㅇㅎㅇ")
                .foregroundStyle(.white)
                .font(.title)
            VStack {
                Button("SHOW") {
                    isPresented = true
                }
                .padding()
                //.background(.white)
                Spacer()
                HStack{
                    Circle()
                    Circle()
                    Circle()
                }
            }
            //.background(.green)
        }
        //화면전환
//        .sheet(isPresented: $isPresented, content: {
//            TamagotchiView()
//        })
        .fullScreenCover(isPresented: $isPresented, content: {
            TamagotchiView()
        })
    }
}

#Preview {
    MovieView()
}
