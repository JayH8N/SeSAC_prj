//
//  GridView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/17/23.
//

import SwiftUI

struct GridView: View {
    
    @Binding var movie: [Movie]
    
    var dummy = Array(1...100).map { "오늘의 영화 순위 \($0)" }
    
    private let layout = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: layout, content: {
                ForEach(dummy, id: \.self) { item in
                    ZStack {
                        Color.random()
                        Text(item)
                    }
                }
            })
            .padding()
        }
        .onAppear {
            //dummy.insert("두둥", at: 0)
        }
        .task { 
            
        }
    }
    
}

#Preview {
    GridView(movie: .constant(
        [
            Movie(name: "SF"),
            Movie(name: "액션"),
            Movie(name: "스릴러"),
            Movie(name: "로맨스"),
            Movie(name: "애니메이션"),
            Movie(name: "가족")
        ]
    ))
}
