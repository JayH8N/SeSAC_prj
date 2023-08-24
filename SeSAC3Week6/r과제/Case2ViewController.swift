//
//  Case2ViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/22.
//

import UIKit
import Kingfisher
import SnapKit

class Case2ViewController: UIViewController {

    let backImageView = imageView()
    
    static func imageView() -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }
    
    let xmark = uiButton(imageName: "xmark")
    let firstButton = uiButton(imageName: "gift.circle")
    let secondButton = uiButton(imageName: "square.and.arrow.up.circle")
    let thirdButton = uiButton(imageName: "gearshape")
    
    static func uiButton(imageName: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }
    
    
    let stackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        return stackView
    }()
    
    let profileImageView = {
       let view = UIImageView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let profileName = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.textAlignment = .center
        nameLabel.text = "화수목"
        return nameLabel
    }()
    
    let profileStackView = {
        let stackView = UIStackView()
        
        //stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    let profileSubLabel = {
        let subLabel = UILabel()
        subLabel.textColor = .white
        subLabel.font = .systemFont(ofSize: 12)
        subLabel.textAlignment = .center
        subLabel.text = "금 - 토 - 일 - 월"
        return subLabel
    }()
    
    
    let bottomButton1 = UIButton()
    let bottomButton2 = UIButton()
    let bottomButton3 = UIButton()
    
    let bottomStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually//.equalCentering
        stackView.spacing = 8
        return stackView
    }()
    
    let uiBottomView = {
        let uiview = UIView()
        
        uiview.backgroundColor = .clear
        uiview.layer.borderColor = UIColor.lightGray.cgColor
        uiview.layer.borderWidth = 0.7
        
        return uiview
    }()
    
    //
    let bottomDot1 = dotLabel()
    let bottomDot2 = dotLabel()
    
    static func dotLabel() -> UILabel {
        let subLabel = UILabel()
        subLabel.font = .systemFont(ofSize: 40)
        subLabel.textAlignment = .center
        subLabel.textColor = .red
        subLabel.text = "."
        return subLabel
    }
    
    
    var backImageURL = "https://cdn.imweb.me/upload/S2020112471695bbb9a79c/21456b9eefe72.jpg"
    
    var profileImage = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //-----
        view.addSubview(backImageView)
        view.addSubview(uiBottomView)
        backImageView.isUserInteractionEnabled = true
        backImageView.addSubview(xmark)
        backImageView.addSubview(firstButton)
        backImageView.addSubview(secondButton)
        backImageView.addSubview(thirdButton)
        backImageView.addSubview(stackView)
        backImageView.addSubview(profileImageView)
        backImageView.addSubview(profileName)
        backImageView.addSubview(profileStackView)
        backImageView.addSubview(profileSubLabel)
        uiBottomView.addSubview(bottomButton1)
        uiBottomView.addSubview(bottomButton2)
        uiBottomView.addSubview(bottomButton3)
        uiBottomView.addSubview(bottomStackView)
        uiBottomView.addSubview(bottomDot1)
        uiBottomView.addSubview(bottomDot2)
        //-----
        
        
        view.backgroundColor = .white
        setBackImageView(image: backImageView, url: backImageURL)
        
        
        
         //버튼3형제 스택뷰
        let buttons = [firstButton, secondButton, thirdButton]
        
        for button in buttons {
            stackView.addArrangedSubview(button)
        }
        
        //프로필 스택뷰
        let profiles = [profileImageView, profileName]
        
        for cp in profiles {
            profileStackView.addArrangedSubview(cp)
        }
        
        //프로필
        setProfileImageView(image: profileImageView, url: profileImage)
        setProfileLabel()
        setProfileStackView()
        setProfileSubLabel()
        
        
        //상단
        setXmark()
        setButton1()
        setButton2()
        setButton3()
        setStackView()
        
        //하단 스택뷰
        let bottomButtons = [bottomButton1, bottomButton2, bottomButton3]
        
        for button in bottomButtons {
            bottomStackView.addArrangedSubview(button)
        }
        
        //bottom
        setBottomUIButton(uiButton: bottomButton1, title: "나와의 채팅", imageName: "message.fill")
        setBottomUIButton(uiButton: bottomButton2, title: "프로필 편집", imageName: "pencil")
        setBottomUIButton(uiButton: bottomButton3, title: "카카오 스토리", imageName: "book.fill")
        setBottomStackView()
        
        //uiViewbottom
        setUIBottomView()
        
        //bottomDot
        setBottomDot1()
        setBottomDot2()
    }
    
    
    //MARK: - imageView
    
    func setBackImageView(image: UIImageView, url: String) {
        image.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
        if let url = URL(string: url) {
            image.kf.setImage(with: url)
        }
        
    }
    
    func setProfileImageView(image: UIImageView, url: String) {
        image.snp.makeConstraints { make in
            make.size.equalTo(90)
        }
        if let url = URL(string: url) {
            image.kf.setImage(with: url)
        }
    }
    
    
    //MARK: - Label
    
    func setProfileLabel() {
        profileName.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
    
    func setProfileSubLabel() {
        profileSubLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(30)
            make.trailingMargin.equalTo(-30)
            make.top.equalTo(profileStackView.snp.bottom).offset(2)
        }
    }
    
    
    //MARK: - Xmark
    func setXmark() {
        print(#function)
        xmark.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(7)
            make.leading.equalTo(16)
            make.size.equalTo(22)
        }
        
        xmark.addTarget(self, action: #selector(Self.closeButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func closeButtonClicked() {
        print("====")
        dismiss(animated: true)
    }
    
    //MARK: - 버튼3형제
    
    func setButton1() {
        firstButton.snp.makeConstraints { make in
            make.size.equalTo(33)
        }
    }
    
    func setButton2() {
        secondButton.snp.makeConstraints { make in
            make.size.equalTo(33)
        }
    }
    
    func setButton3() {
        firstButton.snp.makeConstraints { make in
            make.size.equalTo(33)
        }
    }
    
    func setStackView() {
        stackView.snp.makeConstraints { make in
            make.trailingMargin.equalTo(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            //make.height.equalTo(40)
        }
    }
    
    //프로필 스택뷰
    func setProfileStackView() {
        profileStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(1.44)
        }
    }
    
    //bottom 버튼
    func setBottomUIButton(uiButton: UIButton, title: String, imageName: String) {
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14)
        var button = UIButton.Configuration.plain()
        
        button.titleAlignment = .center

        //이미지 삽입
        button.image = UIImage(systemName: imageName)
        button.imagePadding = 15
        button.imagePlacement = .top
        button.preferredSymbolConfigurationForImage = imageConfig
        
        uiButton.configuration = button
        uiButton.tintColor = .white
        
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        let attributedTitle = NSAttributedString(string: title, attributes: attribute)
        uiButton.setAttributedTitle(attributedTitle, for: .normal)
    }

    
    //bottom스택뷰
    func setBottomStackView() {
        bottomStackView.snp.makeConstraints { make in
            make.leadingMargin.equalTo(40)
            make.trailingMargin.equalTo(-40)
            //make.top.equalTo(profileStackView.snp.bottom).offset(4)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.height.equalTo(90)
        }
    }
    
    
    //uiBottomView
    func setUIBottomView() {
        uiBottomView.snp.makeConstraints { make in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.height.equalTo(138)
        }
    }
    
    //bottomDot
    func setBottomDot1() {
        bottomDot1.snp.makeConstraints { make in
            make.centerX.equalTo(uiBottomView).multipliedBy(1.62)
            make.centerY.equalTo(uiBottomView).multipliedBy(0.46)
        }
    }
    
    func setBottomDot2() {
        bottomDot2.snp.makeConstraints { make in
            make.centerX.equalTo(uiBottomView).multipliedBy(1.09)
            make.centerY.equalTo(uiBottomView).multipliedBy(0.46)
        }
    }
    

}
