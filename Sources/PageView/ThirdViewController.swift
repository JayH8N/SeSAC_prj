//
//  ThirdViewController.swift
//  Media
//
//  Created by hoon on 2023/08/25.
//

import UIKit
import SnapKit


class ThirdViewController: UIViewController {
    
    let buttonOfClose = {
       let button = CloseButtonCustomView()
        button.backgroundColor = .white
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        let attributedTitle = NSAttributedString(string: "Tmdb시작하기", attributes: attribute)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    let buttonOfNonReplay = {
        let button = CloseButtonCustomView()
        button.backgroundColor = .white
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        let attributedTitle = NSAttributedString(string: "다시 보지 않기", attributes: attribute)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    //MARK: - StackView
    let buttonStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 0
        return stackView
    }()
    
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        addSubView()
        setButtonStackView()
    }
    
    //MARK: - addSubView
    func addSubView() {
        view.addSubview(buttonOfClose)
        view.addSubview(buttonOfNonReplay)
        view.addSubview(buttonStackView)
    }
    
    //MARK: - setbutton, StackView
    
    func setButtonStackView() {
        let buttons = [buttonOfClose, buttonOfNonReplay]
        
        for i in buttons {
            buttonStackView.addArrangedSubview(i)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.leading.trailing.equalTo(view).inset(40)
            make.height.equalTo(40)
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
    
    
    
    

    
    
    
}
