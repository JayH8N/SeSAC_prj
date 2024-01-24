//
//  HomeView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/15/23.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 50) {
                ScrollView(.horizontal) {
                    LazyHStack {
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                    }
                }
                ScrollView(.horizontal) {
                    LazyHStack {
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                    }
                }
                ScrollView(.horizontal) {
                    LazyHStack {
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                    }
                }
                ScrollView(.horizontal) {
                    LazyHStack {
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                        AsyncImageView()
                    }
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
