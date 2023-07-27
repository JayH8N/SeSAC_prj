//
//  ViewController.swift
//  EmotionCounter
//
//  Created by hoon on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    var first = userDefaults.integer(forKey: forKey.first.rawValue)
    var second = userDefaults.integer(forKey: forKey.second.rawValue)
    var third = userDefaults.integer(forKey: forKey.third.rawValue)
    var fourth = userDefaults.integer(forKey: forKey.fourth.rawValue)
    var fifth = userDefaults.integer(forKey: forKey.fifth.rawValue)
    
    

    @IBOutlet var emoticons: [UIButton]!
    @IBOutlet var background: UIImageView!
    
    @IBOutlet var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let array = Mood.allCases
        
        for i in 0...emoticons.count - 1 {
            emoticons[i].tag = array[i].rawValue
        }
        setResetButton()
        setEmoticons()
        background.image = UIImage(named: "launch")
        background.contentMode = .scaleAspectFill
    }
    
    //MARK: - 이모티콘사진 삽입 기능
    func setEmoticons() {
        for i in 0...emoticons.count - 1 {
            emoticons[i].setImage(UIImage(named: "emoji\(i + 1)"), for: .normal)
            emoticons[i].tintColor = .systemRed
        }
    }
    //MARK: -
    func setResetButton() {
        resetButton.setTitle("Reset", for: .normal)
        resetButton.tintColor = .systemRed
        resetButton.backgroundColor = .blue
        resetButton.layer.cornerRadius = 5
    }
    //MARK: -
    @IBAction func resetButtonPushed(_ sender: UIButton) {
        first = 0
        second = 0
        third = 0
        fourth = 0
        fifth = 0
        
        userDefaults.set(first, forKey: forKey.first.rawValue)
        userDefaults.set(second, forKey: forKey.second.rawValue)
        userDefaults.set(third, forKey: forKey.third.rawValue)
        userDefaults.set(fourth, forKey: forKey.fourth.rawValue)
        userDefaults.set(fifth, forKey: forKey.fifth.rawValue)
    }
    
    
    
    //MARK: -
    @IBAction func imageTouched(_ sender: UIButton) {
        
        switch Mood(rawValue: sender.tag) {
        case .happy:
            first += 1
            userDefaults.set(first, forKey: forKey.first.rawValue)
        case .smile:
            second += 1
            userDefaults.set(second, forKey: forKey.second.rawValue)
        case .blunt:
            third += 1
            userDefaults.set(third, forKey: forKey.third.rawValue)
        case .sadness:
            fourth += 1
            userDefaults.set(fourth, forKey: forKey.fourth.rawValue)
        case .blue:
            fifth += 1
            userDefaults.set(fifth, forKey: forKey.fifth.rawValue)
        default:
            break
        }
        
    }
    
}
