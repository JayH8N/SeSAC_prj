//
//  ThirdViewController.swift
//  Media
//
//  Created by hoon on 2023/08/25.
//

import UIKit
import SnapKit


class SecondViewController: UIViewController {
    
    let buttonOfClose = setButton(title: "Tmdb Start", titleSize: 20)
    let buttonOfNonReplay = setButton(title: "Don't Watch it again", titleSize: 20)

    
    static func setButton(title: String, titleSize: CGFloat) -> UIButton {
        let button = UIButton()
        button.layer.addBorder([.bottom], width: 3, color: UIColor.green.cgColor)
        button.backgroundColor = .clear
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: titleSize)]
        let attributedTitle = NSAttributedString(string: title, attributes: attribute)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(UIColor(red: 27/255, green: 150/255, blue: 101/255, alpha: 1), for: .normal)
        button.tintColor = .white
        return button
    }
    
    let logoImage = {
       let image = UIImageView()
        let url = "https://play-lh.googleusercontent.com/bBT7rPEvIr2tvzaXcoIdxeeFd8GNUbpWVl94tmiWOwrzwbjMwzDwyhNvAIl5t37u0c8"
        if let url = URL(string: url) {
            image.kf.setImage(with: url)
        }
        return image
    }()
    
    let guideLabel = {
        let label = UILabel()
        label.text = "Get various information through TMDB!!"
        label.textColor = UIColor(red: 27/255, green: 150/255, blue: 101/255, alpha: 1)
        label.font = .boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        addSubView()
        setButtons()
        setLogoImage()
        setGuideLabel()
    }
    
    //MARK: - addSubView
    func addSubView() {
        view.addSubview(buttonOfClose)
        view.addSubview(buttonOfNonReplay)
        view.addSubview(logoImage)
        view.addSubview(guideLabel)
    }
    
    //MARK: - setbutton, StackView
    
    func setButtons() {
        
        buttonOfClose.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(1.9)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(buttonOfClose.snp.width).multipliedBy(0.3)
        }
        
        buttonOfNonReplay.snp.makeConstraints { make in
            make.centerY.equalTo(buttonOfClose)
            make.leading.equalTo(buttonOfClose.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(buttonOfClose.snp.width).multipliedBy(1)
            make.height.equalTo(buttonOfClose.snp.height)
        }
        
        
        setButtonOfClose()
        setButtonOfNonReplay()
    }
    
    func setButtonOfClose() {
        buttonOfClose.addTarget(self, action: #selector(buttonOfCloseClicked), for: .touchUpInside)
    }
    
    @objc func buttonOfCloseClicked() {

//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
//        let nav = UINavigationController(rootViewController: vc)
//
//        nav.modalTransitionStyle = .crossDissolve
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
        
        let tab = TabBarController()
        
        tab.modalTransitionStyle = .crossDissolve
        tab.modalPresentationStyle = .fullScreen
        present(tab, animated: true)
        
    }
    
    func setButtonOfNonReplay() {
        buttonOfNonReplay.addTarget(self, action: #selector(buttonOfNonReplayClicked), for: .touchUpInside)
    }
    
    @objc func buttonOfNonReplayClicked() {
        
        UseerDefaultsHelper.standard.isLaunched = true
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: MainViewController.identifier) as! MainViewController
//        let nav = UINavigationController(rootViewController: vc)
//
//        nav.modalTransitionStyle = .crossDissolve
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
        
        let tab = TabBarController()
        
        tab.modalTransitionStyle = .crossDissolve
        tab.modalPresentationStyle = .fullScreen
        present(tab, animated: true)
    }
    
    //MARK: - logoImage
    
    func setLogoImage() {
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.size.equalTo(150)
        }
    }
    
    //MARK: - setGuideLabel
    
    func setGuideLabel() {
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
    }

    
    
    
}
