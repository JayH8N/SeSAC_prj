//
//  FilterButtonVC.swift
//  Pantry
//
//  Created by hoon on 2023/10/19.
//

import UIKit
import Then
import SnapKit

class FilterButtonVC: BaseViewController {
    
    weak var delegate: BulletinDelegate?
    
    
    let bgView = UIView().then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.roundCorners(cornerRadius: 30, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        $0.layer.cornerRadius = 30
        $0.isUserInteractionEnabled = true
    }
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
        $0.text = NSLocalizedString("SelectSort", comment: "")
    }
    
    let cancelButton = UIButton(type: .system).then {
        $0.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.setBackgroundColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    
    let applyButton = UIButton(type: .system).then {
        $0.setTitle(NSLocalizedString("Apply", comment: ""), for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.setBackgroundColor(UIColor.refrigerCellBackground, for: .normal)
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    
    lazy var buttonStackView = UIStackView(arrangedSubviews: [cancelButton, applyButton]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    lazy var radioButton1 = CustomRadioButton().then {
        $0.titleLabel.text = NSLocalizedString("SortNetAdded", comment: "")
        $0.tag = 1
    }
    
    lazy var radioButton2 = CustomRadioButton().then {
        $0.titleLabel.text = NSLocalizedString("SortFastestDate", comment: "")
        $0.tag = 2
    }
    
    lazy var radioButton3 = CustomRadioButton().then {
        $0.titleLabel.text = NSLocalizedString("SortSlowestDate", comment: "")
        $0.tag = 3
    }
    
    lazy var radioButton4 = CustomRadioButton().then {
        $0.titleLabel.text = NSLocalizedString("ExpiredGoods", comment: "")
        $0.tag = 4
    }
    
    lazy var radioButtonStackView = UIStackView(arrangedSubviews: [radioButton1, radioButton2, radioButton3, radioButton4]).then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    
    static func instance() -> FilterButtonVC {
        return FilterButtonVC(nibName: nil, bundle: nil).then {
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let initialSelectedButton = view.viewWithTag(1) as? CustomRadioButton {
            initialSelectedButton.isSelected = true
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    override func configureView() {
        view.backgroundColor = .clear
        view.addSubview(bgView)
        bgView.addSubview(blurEffect)
        bgView.addSubview(titleLabel)
        
        cancelButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        applyButton.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)
        
        bgView.addSubview(buttonStackView)
        bgView.addSubview(radioButtonStackView)
        
        let radioButton1TapGesture = UITapGestureRecognizer(target: self, action: #selector(radioButtonTapped))
               radioButton1.addGestureRecognizer(radioButton1TapGesture)
        let radioButton2TapGesture = UITapGestureRecognizer(target: self, action: #selector(radioButtonTapped))
                radioButton2.addGestureRecognizer(radioButton2TapGesture)
        let radioButton3TapGesture = UITapGestureRecognizer(target: self, action: #selector(radioButtonTapped))
                radioButton3.addGestureRecognizer(radioButton3TapGesture)
        let radioButton4TapGesture = UITapGestureRecognizer(target: self, action: #selector(radioButtonTapped))
                radioButton4.addGestureRecognizer(radioButton4TapGesture)
        
    }
    
    @objc func radioButtonTapped(sender: UITapGestureRecognizer) {
        HapticFeedbackManager.shared.provideFeedback()
        if let selectedButton = sender.view as? CustomRadioButton {
            handleRadioButtonSelection(selectedButton)
        }
    }
    
    func handleRadioButtonSelection(_ selectedButton: CustomRadioButton) {
        selectedButton.isSelected.toggle()
        
        for button in [radioButton1, radioButton2, radioButton3, radioButton4] {
            if button != selectedButton {
                button.isSelected = false
            }
        }
        switch selectedButton.tag {
        case 1:
            print("=== 1 ===")
        case 2:
            print("=== 2 ===")
        case 3:
            print("=== 3 ===")
        case 4:
            print("=== 4 ===")
        default:
            break
        }
    }
    
    
    
    
    override func setConstraints() {
        bgView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.top.equalToSuperview().inset(20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(40)
            $0.bottom.equalTo(bgView.snp.bottom).inset(35)
        }
        
        radioButtonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(34)
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-18)
        }
        
        
    }
    

}

extension FilterButtonVC {
    @objc func closeTapped() {
        HapticFeedbackManager.shared.provideFeedback()
        
        delegate?.onTapClose()
        dismiss(animated: true)
    }
    
    //적용 reloadData필요
    @objc func applyTapped() {
        HapticFeedbackManager.shared.provideFeedback()
        
        delegate?.onTapClose()
        dismiss(animated: true)
    }
    
    
}
