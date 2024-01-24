//
//  Data.swift
//  Tamagotchi
//
//  Created by hoon on 2023/08/04.
//

import UIKit


struct Tamagotchi {
    var title: String
    var image: String
    var introduction: String
}

struct DetailTamagotchi {
    
    static var shared = DetailTamagotchi()
    
    var list = [Tamagotchi(title: "따끔따끔 다마고치", image: "1-6", introduction: "저는 선인장 다마고치 입니다. 키는 2cm\n몸무게는 150g이에요.\n성격은 소심하지만 마음은 따뜻해요.\n열심히 잘 먹고 잘 클 자신은 있답니다.\n반가워요 주인님!!!"),
                Tamagotchi(title: "방실방실 다마고치", image: "2-6", introduction: "저는 방실방실 다마고치입니당 키는 100km\n몸무게는 150톤이에용\n성격은 화끈하고 날라다닙니당~!\n열심히 잘 먹고 잘 클 자신은\n있답니당 방실방실!" ),
                Tamagotchi(title: "반짝반짝 다마고치", image: "3-6", introduction: "저는 반짝반짝 다마고치에요~ 키는 120cm 몸무게는 120g이에요~ 성격도 반짝반짝 시원시원 해요~ 저를 키워주세요~ 잘 먹고 잘 커볼게요~")]
    
    private init() {
        addCharacter()
    }
    
    mutating func addCharacter() {
        let inactive = Tamagotchi(title: "준비중이에요", image: "noImage", introduction: "준비중이에요~")
        for _ in 1...20 {
            list.append(inactive)
        }
    }
}

let themeColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
let borderColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1).cgColor
let fontColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)

