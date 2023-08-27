//
//  BaeminViewController.swift
//  Baemin
//
//  Created by hoon on 2023/08/26.
//

import UIKit
import SnapKit

class BaeminViewController: UIViewController {

    //MARK: - NavigationBar 영역 or 상단부
    let mainTopView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 118/255, green: 194/255, blue: 191/255, alpha: 1)
        view.roundCorners(cornerRadius: 25, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        return view
    }()
    
    let titleButton = {
        let button = NavigationBarButtonCustom()
        button.setView()
        button.setTitle("회사", for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    
//    let leftBarItem = {
//        let button = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: BaeminViewController.self, action: #selector(leftBarItemClicked))
//        button.tintColor = .white
//        return button
//    }()
//
//    let rightBarItem1 = {
//        let button = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: BaeminViewController.self, action: #selector(rightBarItem1Clicked))
//        button.tintColor = .white
//        return button
//    }()
//
//    let rightBarItem2 = {
//        let button = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: BaeminViewController.self, action: #selector(rightBarItem2Clicked))
//        button.tintColor = .white
//        return button
//    }()
//
//    let leftBarItem = {
//        let button = NavigationBarButtonCustom()
//        button.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
//        return button
//    }()
//
//        let rightBarItem1 = {
//            let button = NavigationBarButtonCustom()
//            button.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
//            return button
//        }()
//
//        let rightBarItem2 = {
//            let button = NavigationBarButtonCustom()
//            button.setImage(UIImage(systemName: "bell"), for: .normal)
//            return button
//        }()
    
    let leftBarItem = navigationBarItem(imageName: "square.grid.2x2", imageSize: 18, color: .white, leading: 0, trailing: 20)
    let rightBarItem1 = navigationBarItem(imageName: "person.crop.circle", imageSize: 18, color: .white, leading: 20, trailing: 0)
    let rightBarItem2 = navigationBarItem(imageName: "bell", imageSize: 18, color: .white, leading: 8, trailing: 0)
    
    
        
    static func navigationBarItem(imageName: String, imageSize: CGFloat, color: UIColor, leading: CGFloat, trailing: CGFloat) -> UIButton {
        let uiButton = UIButton()
        let setImage = UIImage.SymbolConfiguration(pointSize: imageSize, weight: .regular)
        
        let image = UIImage(systemName: imageName, withConfiguration: setImage)
        uiButton.setImage(image, for: .normal)
        uiButton.tintColor = color
        
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 10, leading: leading, bottom: 10, trailing: trailing)
        config.image = UIImage(systemName: imageName)
        config.baseBackgroundColor = .clear
        uiButton.configuration = config
        return uiButton
    }

    
    let searchBar = {
        let search = UISearchBar()
        search.placeholder = "포케? 돈까스? 커리?"
        search.searchTextField.backgroundColor = .clear
        search.searchTextField.leftView?.tintColor = UIColor(red: 118/255, green: 194/255, blue: 191/255, alpha: 1)
        return search
    }()
    
    //MARK: - 서치바 하단부분 객체
    
    let button1 = {
        let button = MainScreenButtonsCustom()
        return button
    }()
    
    let button2 = {
        let button = MainScreenButtonsCustom()
        return button
    }()
    
    let button3 = {
        let button = MainScreenButtonsCustom()
        return button
    }()
    
    let button4 = {
        let button = MainScreenButtonsCustom()
        return button
    }()

    let button5 = {
        let button = MainScreenButtonsCustom()
        return button
    }()
    
    let button6 = {
        let button = MainScreenButtonsCustom()
        return button
    }()
    
    let button7 = {
        let button = MainScreenButtonsCustom()
        return button
    }()
    
    let button8 = {
        let button = MainScreenButtonsCustom()
        return button
    }()
    
    //MARK: - StackView
    
    lazy var righthStackview = {
        let stackView = UIStackView.init(arrangedSubviews: [rightBarItem1, rightBarItem2])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubView()
        setNavigationBarItem()
        setMainTopView()
        setSearchBar()
        setMainScreenButtons()
        
        
        
    }
    
    //MARK: - NavigationBarItem
    
    func setNavigationBarItem() {
        navigationItem.titleView = titleButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarItem)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: righthStackview)
    }
    
    @objc func leftBarItemClicked() {
        print("leftBarButton")
    }
    
    @objc func rightBarItem1Clicked() {
        print("rightBarButton")
    }
    
    @objc func rightBarItem2Clicked() {
        print("rightBarButton")
    }
    
    
    
    
    //MARK: - addSubView
    
    func addSubView() {
        let views = [mainTopView, button1, button2, button3, button4, button5, button6, button7, button8]

        for i in views {
            view.addSubview(i)
        }
        //
        mainTopView.addSubview(searchBar)
        
    }
    
    
    //MARK: - mainTopView
    
    func setMainTopView() {
        mainTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.19)
        }
    }
    
    //MARK: - searchBar
    
    func setSearchBar() {
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(searchBar.snp.width).multipliedBy(0.12)
        }
    }
    
    //MARK: - MainScreenButtons
    
    
    func setMainScreenButtons() {
        button1.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(mainTopView.snp.bottom).offset(16)
            make.height.equalTo(button1.snp.width)
        }
        
        button2.snp.makeConstraints { make in
            make.leading.equalTo(button1.snp.trailing).offset(16)
            make.trailing.equalTo(view).inset(16)
            make.top.equalTo(mainTopView.snp.bottom).offset(16)
            make.width.equalTo(button1.snp.width).multipliedBy(1)
            make.height.equalTo(button1.snp.width)
        }
        
        button3.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view).inset(16)
            make.height.equalTo(button1.snp.height).multipliedBy(0.5)
        }
        
        button4.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(button3.snp.bottom).offset(16)
            make.height.equalTo(button1.snp.height).multipliedBy(0.53)
        }
        
        button5.snp.makeConstraints { make in
            make.leading.equalTo(button4.snp.trailing).offset(16)
            make.trailing.equalTo(view).inset(16)
            make.top.equalTo(button3.snp.bottom).offset(16)
            make.width.equalTo(button4.snp.width).multipliedBy(1)
            make.height.equalTo(button4.snp.height)
        }
        
        button6.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(button4.snp.bottom).offset(16)
            make.height.equalTo(button4.snp.height)
        }
        
        button7.snp.makeConstraints { make in
            make.leading.equalTo(button6.snp.trailing).offset(16)
            make.trailing.equalTo(view).inset(16)
            make.top.equalTo(button5.snp.bottom).offset(16)
            make.width.equalTo(button6.snp.width).multipliedBy(1)
            make.height.equalTo(button4.snp.height)
        }
        
        button8.snp.makeConstraints { make in
            make.top.equalTo(button7.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    
    
    

    
}
