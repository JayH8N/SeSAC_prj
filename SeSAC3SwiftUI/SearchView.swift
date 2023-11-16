//
//  SearchView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/16/23.
//

import SwiftUI

//struct SearchView: View {
//
//    @State var randomNumber = 0
//
//    init(randomNumber: Int = 0) {
//        self.randomNumber = randomNumber
//        print("SearchView init")
//    }
//
//    var body: some View {
//        VStack {
//            HueView()
//            jackView
//            kokoView()
//            Text("Brann \(randomNumber)")
//                .background(Color.random())
//            Button("클릭") {
//                randomNumber = Int.random(in: 1...100)
//            }
//        }
//    }
//
//    var jackView: some View {
//        Text("Jack")
//            .background(Color.random())
//    }
//
//    func kokoView() -> some View {
//        Text("Koko")
//            .background(Color.random())
//    }
//}


struct Movie: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let color = Color.random()
}

struct SearchView: View {
    
    @State private var searchQuery = "ㅇㅇ"
    
    let movie = [
        Movie(name: "어벤져스"), Movie(name: "해리포터1"),
        Movie(name: "아이언맨3"), Movie(name: "인셉션1"),
        Movie(name: "엑스맨"), Movie(name: "신과함께2"),
    ]
    
    var filterMovie: [Movie] {
        return searchQuery.isEmpty ? movie: movie.filter{ $0.name.contains(searchQuery) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filterMovie, id: \.self) { item in
                    //                    NavigationLink {
                    //                        SearchDetailView(movie: item)
                    //                        } label: {
                    //                        HStack {
                    //                            Circle().foregroundStyle(item.color)
                    //                            Text(item.name)
                    //                                .navigationTitle("검색")
                    //                        }
                    //                        .frame(height: 60)
                    //                    }
                    NavigationLink(value: item) {
                        HStack {
                            Circle().foregroundStyle(item.color)
                            Text(item.name)
                                .navigationTitle("검색")
                        }
                        .frame(height: 60)
                    }
                }
            }
            .navigationTitle("검색")
            .navigationDestination(for: Movie.self) { item in
                SearchDetailView(movie: item)
            }
        }
        .searchable(text: $searchQuery,
                    placement: .navigationBarDrawer,
                    prompt: "검색해봐")
        .onSubmit(of: .search) {
            print("aldkfja")
        }
    }
}

struct SearchDetailView: View {
    
    @State var movie: Movie
    
    var body: some View {
        Text(movie.name)
            .navigationTitle(movie.name)
        VStack {
            Button("기본 버튼") {
                print("기본버튼")
            }
            Button(action: {
                print("dasdf")
            }, label: {
                HStack {
                    Circle().foregroundStyle(Color.red)
                    Text("Button")
                }
            })
            .frame(width: 200, height: 100)
        }
    }
    
    
}

#Preview {
    SearchView()
}

struct HueView: View {
    
    init() {
        print("HueView init")
    }
    
    var body: some View {
        Text("Hue")
            .background(Color.random())
    }
    // => 연산프로퍼티
    
}


extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
    
}
