//
//  PosterView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/15/23.
//

import SwiftUI

/*
 ScrollView
 LazyVStack vs VStack
 List
 */

struct PosterView: View {
    
    @State private var isPreseneted = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(0..<50) { item in
                   //Text("\(item)").lineLimit(2)
                    AsyncImageView()
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            print("탭탭")
                            isPreseneted.toggle()
                        }
                }
            }
//            .frame(maxWidth: .infinity)
        }
        .background(.gray)
        .sheet(isPresented: $isPreseneted, content: {
            RenderView()
        })
//        .contentMargins(50, for: .scrollIndicators)
    }
}


struct AsyncImageView: View {
    
    let url = URL(string: "https://picsum.photos/200")
    
    var body: some View {
        AsyncImage(url: url) { data in
            switch data {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .frame(width: 100, height: 100)
                    .scaledToFill()
                    .clipShape(Circle())
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            case .failure(_):
                Image(systemName: "star")
            @unknown default:
                Image(systemName: "star")
            }
        }
    }
}


#Preview {
    PosterView()
}


//AsyncImage(url: url) { image in
//    image
//        .frame(width: 200, height: 200)
//        .scaledToFill()
//        .clipShape(Circle())
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//} placeholder: {
//    //Image(systemName: "star")
//    ProgressView()
//}
