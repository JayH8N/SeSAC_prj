//
//  MenuView.swift
//  SeSAC3SwiftUI
//
//  Created by hoon on 11/13/23.
//

import SwiftUI

struct MenuView: View {
    var cardProperty: some View {
        VStack (spacing: 20) {
            Image(systemName: "star")
                .background(.blue)
            Text("text")
                .background(.green)
        }
        .padding()
        .background(.yellow)
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack (spacing: 20) {
                cardProperty
                CardView(image: "person", text: "고객 센터")
                CardView(image: "pencil", text: "토스 증권")
            }
            List {
                ExtractedView(sectionTitle: "자산")
                ExtractedView(sectionTitle: "2번")
                ExtractedView(sectionTitle: "3번")
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    MenuView()
}

struct CardView: View {
    
    let image: String
    let text: String
    
    
    var body: some View {
        VStack (spacing: 20) {
            Image(systemName: image)
                .background(.blue)
            Text(text)
                .background(.green)
                .underline()
                .strikethrough()
        }
        .padding()
        .background(.yellow)
    }
}

struct PointBorderText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(10)
            .foregroundStyle(.white)
            .background(.purple)
            .clipShape(.capsule)
    }
}

extension View {
    
    func asPointBorderText() -> some View {
        modifier(PointBorderText())
    }
    
}


struct ExtractedView: View {
    
    let sectionTitle: String
    
    var body: some View {
        Section (sectionTitle) {
            Text("보안과 인증")
                .underline()
            ColorPicker("Color설정", selection: /*@START_MENU_TOKEN@*/.constant(.red)/*@END_MENU_TOKEN@*/)
            Text("내 신용점수")
                .asPointBorderText()
            Text("진행 중인 이벤트")
                .asPointBorderText()
        }
    }
}
