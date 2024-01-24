//
//  Enum.swift
//  Tamagotchi
//
//  Created by hoon on 2023/08/06.
//

import Foundation

enum CharacterType: Int {
    case character1
    case character2
    case character3
}


enum ForKey: String {
    case result1 = "1번 결과"
    case result2 = "2번 결과"
    case result3 = "3번 결과"
    case rice1 = "1번 밥"
    case water1 = "1번 물"
    case rice2 = "2번 밥"
    case water2 = "2번 물"
    case rice3 = "3번 밥"
    case water3 = "3번 물"
    case isLaunched = "isLaunched"
    case changeCharacter = "changeCharacter"
}
