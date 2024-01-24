//
//  PopUpViewController.swift
//  Tamagotchi
//
//  Created by hoon on 2023/08/04.
//

import UIKit


class PopUpViewController: UIViewController {
    
    //값전달
    var image: String?
    var name: String?
    var intro: String?
    
    var type: CharacterType?
    
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var characterName: UILabel!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var imageBackView: UIView!
    @IBOutlet var labelBackView: UIView!
    @IBOutlet var introduction: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var startButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterName.setUILabel()
        setPopUpView()
        setBackVeiw()
        setIntroduction()
        setCancelButton()
        setStartButton()
        callValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStartButton()
    }
    
    func setPopUpView() {
        popUpView.setUIview()
        popUpView.layer.cornerRadius = 10
    }
    
    func setBackVeiw() {
        imageBackView.backgroundColor = .clear
        labelBackView.backgroundColor = .clear
    }
    
    func setIntroduction() {
        introduction.backgroundColor = .clear
        introduction.numberOfLines = 0
        introduction.layer.addBorder([.top], width: 0.7)
    }
    
    func setCancelButton() {
        cancelButton.layer.addBorder([.top], width: 0.5)
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.tintColor = fontColor
        cancelButton.backgroundColor = .systemGray5
        cancelButton.clipsToBounds = true
        cancelButton.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMaxYCorner])
    }
    
    func setStartButton() {
        startButton.layer.addBorder([.top], width: 0.5)
        let titleBool = UserDefaults.standard.bool( forKey: ForKey.changeCharacter.rawValue)
        if !titleBool {
            startButton.setTitle("시작하기", for: .normal)
        } else {
            startButton.setTitle("변경하기", for: .normal)
        }
        startButton.tintColor = fontColor
    }
    
    func callValue() {
        guard let image, let name, let intro else {
            characterImage.image = UIImage(systemName: "questionmark")
            characterName.text = "데이터 없어요"
            introduction.text = "데이터 없어요"
            return }
        characterImage.image = UIImage(named: image)
        characterName.text = name
        introduction.text = intro
    }
    
    func callValue(data: Tamagotchi) {
        image = data.image
        name = data.title
        intro = data.introduction
    }
    
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: ForKey.isLaunched.rawValue)
        guard let type else {
            self.alert(title: "존재하지 않는다구~", handler: {action in self.firstViewBack()})
            return }
        
        //화면전환
        let sb = UIStoryboard(name: "TamagotchiMain", bundle: nil)
        let main = sb.instantiateViewController(withIdentifier: TamagotchiMainViewController.identifier) as! TamagotchiMainViewController
        
        
        main.type = type.rawValue
        UserDefaults.standard.set(main.type, forKey: "type")
                
//        let nav = UINavigationController(rootViewController: main)
//        nav.modalPresentationStyle = .overFullScreen
//        present(nav, animated: false)
        
        transition(style: .presentNavigation, sbName: "TamagotchiMain", viewController: TamagotchiMainViewController.self, PresentationStyle: .overFullScreen, animate: false)
    }
    
    
    func firstViewBack() {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
        
        
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalTransitionStyle = .crossDissolve
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
        
        
        transition(style: .presentNavigation, sbName: "Main", viewController: MainViewController.self, PresentationStyle: .fullScreen, TransitionStyle: .crossDissolve, animate: true)
    }
}

extension PopUpViewController: ReusableIdentifier {
    static var identifier: String {
        String(describing: Self.self)
    }
}
