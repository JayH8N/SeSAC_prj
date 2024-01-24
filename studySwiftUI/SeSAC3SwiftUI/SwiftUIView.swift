//
//  SwiftUIView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/15/23.
//

import SwiftUI
/*
 ForEach
 - ..<
 - Swift KeyPath \.
 - id: KeyPath => item
 - Hahsable
 */

struct Category: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let count: Int
}


struct SwiftUIView: View {
    
    let category = [
        Category(name: "스릴러", count: 10),
        Category(name: "액션", count: 50),
        Category(name: "SF", count: 17),
        Category(name: "로맨스", count: 11),
        Category(name: "애니메이션", count: 1),
        Category(name: "로맨스", count: 10),
        Category(name: "로맨스", count: 8),
    ]
    
    var body: some View {
        VStack {
            ForEach(category, id: \.id) { item in
                Text("\(item.name) \(item.count) 안녕하세요")
                    .font(.largeTitle)
            }
        }
    }
}



#Preview {
    SwiftUIView()
}
