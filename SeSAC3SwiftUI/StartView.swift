//
//  StartView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/15/23.
//

import SwiftUI

struct StartView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Text("홈 화면")
                    Image(systemName: "house.fill")
                }
            PosterView()
                .tabItem {
                    Text("검색 화면")
                    Image(systemName: "star.fill")
                }
            RenderView()
                .tabItem {
                    Text("설정 화면")
                    Image(systemName: "house.fill")
                }
        }
    }
}

#Preview {
    StartView()
}
