//
//  SetPersonalModel.swift
//  SeSACgram
//
//  Created by hoon on 11/28/23.
//

import Foundation

struct SetPersonalItem {
    var imageName: String?
    let title: String
}

struct SetPersonalSection {
    
    init(items: [SetPersonalItem], header: String) {
        self.items = items
        self.header = header
    }
    
    let items: [SetPersonalItem]
    let header: String
    
    static func generateData() -> [SetPersonalSection] {
        return [
            SetPersonalSection(items: [SetPersonalItem(title: Menu.Setpersonal.logout.rawValue),
                                       SetPersonalItem(title: Menu.Setpersonal.withdraw.rawValue)
                                      ],
                               header: "로그인")
        ]
    }
}
