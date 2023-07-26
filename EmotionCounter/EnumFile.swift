//
//  MoodEnum.swift
//  EmotionCounter
//
//  Created by hoon on 2023/07/25.
//

import Foundation

enum Mood: Int, CaseIterable {
    case happy, smile, blunt, sadness, blue
}

enum forKey: String {
    case first = "first"
    case second = "second"
    case third = "third"
    case fourth = "fourth"
    case fifth = "fifth"
}

let userDefaults = UserDefaults.standard

var result1 = 0
var result2 = 0
var result3 = 0
var result4 = 0
var result5 = 0
