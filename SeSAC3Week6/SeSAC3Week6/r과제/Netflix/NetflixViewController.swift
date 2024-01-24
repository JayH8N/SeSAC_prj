//
//  NetflixViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/24.
//

import UIKit
import SnapKit

class NetflixViewController: UIViewController {
    
    let backImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "어벤져스엔드게임")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let opacityView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        return imageView
    }()
    
    let mainLogo = {
        let logo = UILabel()
        logo.text = "N"
        logo.textColor = .white
        logo.font = .boldSystemFont(ofSize: 60)
        return logo
    }()
    
    let topLabel1 = {
        let label = TopButtonLabel()
        label.setUpView()
        label.text = "TV프로그램"
        return label
    }()
    
    let topLabel2 = {
        let label = TopButtonLabel()
        label.setUpView()
        label.text = "영화"
        return label
    }()
    
    let topLabel3 = {
        let label = TopButtonLabel()
        label.setUpView()
        label.text = "내가 찜한 콘텐츠"
        return label
    }()
    
    var middleButton1 = UIButton()
    let middleButton2 = {
        let button = UIButton()
        button.setImage(UIImage(named: "play_normal"), for: .normal)
        button.setImage(UIImage(named: "play_highlighted"), for: .highlighted)
        return button
    }()
    var middleButton3 = UIButton()
    
    let subView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let smallLabel = {
        let label = UILabel()
        label.text = "미리보기"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let imageView1 = {
        let imageView = CircleImageView(frame: .zero)
        imageView.setupView()
        imageView.image = UIImage(named: "2")
        return imageView
    }()
    
    let imageView2 = {
        let imageView = CircleImageView(frame: .zero)
        imageView.setupView()
        imageView.image = UIImage(named: "암살")
        return imageView
    }()
    
    let imageView3 = {
        let imageView = CircleImageView(frame: .zero)
        imageView.setupView()
        imageView.image = UIImage(named: "아바타")
        return imageView
    }()
    
    //MARK: - StackView
    
    let topLabelStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 13
        return stackView
    }()
    
    let middleButtonStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 11
        return stackView
    }()
    
    let bottomImageStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .black
        addSubView()
        setBackImageView()
        setOpacityView()
        setMainLogo()
        setTopLabelStackView()
        setMiddleUIButton()
        setSubView()
        setSmallLabel()
        setbottomImages()
    }
    
    //MARK: - addSubView
    
    func addSubView() {
        view.addSubview(backImage)
        view.addSubview(opacityView)
        view.addSubview(mainLogo)
        view.addSubview(topLabel1)
        view.addSubview(topLabel2)
        view.addSubview(topLabel3)
        view.addSubview(topLabelStackView)
        view.addSubview(middleButton1)
        view.addSubview(middleButton2)
        view.addSubview(middleButton3)
        view.addSubview(middleButtonStackView)
        view.addSubview(subView)
        subView.addSubview(smallLabel)
        subView.addSubview(imageView1)
        subView.addSubview(imageView2)
        subView.addSubview(imageView3)
        subView.addSubview(bottomImageStackView)
    }
    
    
    //MARK: - backImage
    
    func setBackImageView() {
        backImage.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.8)
        }
    }
    
    //MARK: - opacityView
    
    func setOpacityView() {
        opacityView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
    }
    
    //MARK: - mainLogo
    
    func setMainLogo() {
        mainLogo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(12)
        }
    }

    //MARK: - StackView
    
    func setTopLabelStackView() {
        let labels = [topLabel1, topLabel2, topLabel3]
        for i in labels {
            topLabelStackView.addArrangedSubview(i)
        }
        
        
        topLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(33)
            make.trailing.equalTo(-30)
            make.leading.equalTo(mainLogo.snp.trailing).offset(30)
        }
    }

    //MARK: - middelUIButton
    
    func setMiddleUIButton() {
        setUIButton(uiButton: middleButton1, title: "내가 찜한 컨텐츠", imageName: "check" ,imageSize: 40, titleSize: 13)
        setUIButton(uiButton: middleButton3, title: "정보", imageName: "info", imageSize: 30, titleSize: 13)
        
        let buttons = [middleButton1, middleButton2, middleButton3]
        for i in buttons {
            middleButtonStackView.addArrangedSubview(i)
        }
        
        middleButtonStackView.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(50)
            make.centerY.equalTo(view).multipliedBy(1.45)
        }
        
    }
    
    //MARK: - SubView
    
    func setSubView() {
        subView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(middleButtonStackView.snp.bottom)
        }
    }
    
    //MARK: - smallLabel
    
    func setSmallLabel() {
        smallLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(subView)
            make.height.equalTo(30)
        }
    }
    
    
    //MARK: - bottomImage
    
    func setbottomImages() {
        
        let images = [imageView1, imageView2, imageView3]
        
        for i in images {
            bottomImageStackView.addArrangedSubview(i)
        }
        
        bottomImageStackView.snp.makeConstraints { make in
            make.top.equalTo(smallLabel.snp.bottom)
            make.leading.trailing.equalTo(subView).inset(8)
            make.height.equalTo(imageView1.snp.width)
        }
        
    }

}









//MARK: - extension

extension NetflixViewController {
    func setUIButton(uiButton: UIButton, title: String, imageName: String, imageSize: CGFloat, titleSize: CGFloat) -> UIButton {
        var button = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: imageSize)
        button.titleAlignment = .center
        button.image = UIImage(named: imageName)
        button.imagePadding = 6
        button.imagePlacement = .top
        button.preferredSymbolConfigurationForImage = imageConfig
        uiButton.configuration = button
        uiButton.tintColor = .white
        
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: titleSize)]
        let attributedTitle = NSAttributedString(string: title, attributes: attribute)
        uiButton.setAttributedTitle(attributedTitle, for: .normal)
        return uiButton
    }
}
