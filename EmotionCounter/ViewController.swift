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
        for i in 0...emoticons.count - 1 {
           emoticons[i].setImage(UIImage(named: "emoji\(i + 1)"), for: .normal)
        }
    }

    
//MARK: -
    @IBAction func imageTouched(_ sender: UIButton) {
        
        switch sender.tag {
        case Mood.happy.rawValue:
            happy += 1
            print(happy)
        case Mood.smile.rawValue:
            smile += 1
            print(smile)
        case Mood.blunt.rawValue:
            blunt += 1
            print(blunt)
        case Mood.sadness.rawValue:
            sadness += 1
            print(sadness)
        case Mood.blue.rawValue:
            blue += 1
            print(blue)
        default:
            break
        }
    }
    
    
}
