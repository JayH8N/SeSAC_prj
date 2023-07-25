//
//  ViewController.swift
//  EmotionCounter
//
//  Created by hoon on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var emoticons: [UIButton]!
    @IBOutlet var background: UIImageView!
    
    @IBOutlet var pullDownButton: UIButton!
    
    let firstButton = Mood.happy.rawValue
    let secondButton = Mood.smile.rawValue
    let thirdButotn = Mood.blunt.rawValue
    let fourthButton = Mood.sadness.rawValue
    let fifthButton = Mood.blue.rawValue
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
        
        happy = 0
        smile = 0
        blunt = 0
        sadness = 0
        blue = 0
        
        titleLabel.text = "OH MY MOOD"
        titleLabel.textAlignment = .center
        setEmoticons()
        background.image = UIImage(named: "launch")
        background.contentMode = .scaleAspectFill
       pullDownButton.setImage(UIImage(named: "ellipsis"), for: .normal)
       // ???:
//       pullDownButton.image = UIImage(systemName: "ellipsis")
    }
    
//MARK: - 이모티콘사진 삽입 기능
    func setEmoticons() {
        for i in 0...4 {
           emoticons[i].setImage(UIImage(named: "emoji\(i + 1)"), for: .normal)
        }
    }

    
//MARK: -
    @IBAction func imageTouched(_ sender: UIButton) {
        
        switch sender.tag {
        case firstButton:
            happy += 1
            print(happy)
        case secondButton:
            smile += 1
            print(smile)
        case thirdButotn:
            blunt += 1
            print(blunt)
        case fourthButton:
            sadness += 1
            print(sadness)
        case fifthButton:
            blue += 1
            print(blue)
        default:
            break
        }
    }
    
    
}
