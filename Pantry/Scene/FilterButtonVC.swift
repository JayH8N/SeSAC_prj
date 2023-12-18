//
//  FilterButtonVC.swift
//  Pantry
//
//  Created by hoon on 2023/10/19.
//

import UIKit
import Then
import SnapKit

class FilterButtonVC: BaseVC {
    
    weak var delegate: BulletinDelegate?
    var selectedSort: Sort?
    var pageOption: PageOption?
    var buttonSignal: FilterButtonSignal? //filter누르고 바로 확인누르면 옵셔널이라 오류날듯
    
    let bgView = UIView().then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.roundCorners(cornerRadius: 30, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        $0.layer.cornerRadius = 30
        $0.isUserInteractionEnabled = true
    }
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    lazy var titleLabel = UILabel().then {
        $0.textColor = .black
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
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.setBackgroundColor(UIColor.black, for: .normal)
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
        
        if let selectedSort = selectedSort {
            switch selectedSort {
            case .Added:
                if let selectedButton = view.viewWithTag(1) as? CustomRadioButton {
                    selectedButton.isSelected = true
                }
            case .ExpFastest:
                if let selectedButton = view.viewWithTag(2) as? CustomRadioButton {
                    selectedButton.isSelected = true
                }
            case .ExpSlowest:
                if let selectedButton = view.viewWithTag(3) as? CustomRadioButton {
                    selectedButton.isSelected = true
                }
            case .ExpiredGoods:
                if let selectedButton = view.viewWithTag(4) as? CustomRadioButton {
                    selectedButton.isSelected = true
                }
            }
        }
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
        if selectedButton.isSelected {
            return
        }
        
        selectedButton.isSelected.toggle()
        
        for button in [radioButton1, radioButton2, radioButton3, radioButton4] {
            if button != selectedButton {
                button.isSelected = false
            }
        }
        
        
        switch selectedButton.tag {
        case 1:
            switch pageOption {
            case .All: buttonSignal = .all_added
            case .Refrigerator: buttonSignal = .ref_Added
            case .Frozen: buttonSignal = .f_added
            default: break
            }
        case 2:
            switch pageOption {
            case .All: buttonSignal = .all_expFastest
            case .Refrigerator: buttonSignal = .ref_expFastest
            case .Frozen: buttonSignal = .f_expFastest
            default: break
            }
        case 3:
            switch pageOption {
            case .All: buttonSignal = .all_expSlowest
            case .Refrigerator: buttonSignal = .ref_expSlowest
            case .Frozen: buttonSignal = .f_expSlowest
            default: break
            }
        case 4:
            switch pageOption {
            case .All: buttonSignal = .all_expiredGoods
            case .Refrigerator: buttonSignal = .ref_expiredGoods
            case .Frozen: buttonSignal = .f_expiredGoods
            default: break
            }
        default: break
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
    
    
    @objc func applyTapped() {
        HapticFeedbackManager.shared.provideFeedback()
        
        switch buttonSignal {
        case.all_added: NotificationCenter.default.post(name: Notification.Name("All_Added"), object: nil)
        case .all_expFastest: NotificationCenter.default.post(name: Notification.Name("All_ExpFastest"), object: nil)
        case .all_expSlowest: NotificationCenter.default.post(name: Notification.Name("All_ExpSlowest"), object: nil)
        case .all_expiredGoods: NotificationCenter.default.post(name: Notification.Name("All_ExpiredGoods"), object: nil)
        case .ref_Added: NotificationCenter.default.post(name: Notification.Name("Ref_Added"), object: nil)
        case .ref_expFastest: NotificationCenter.default.post(name: Notification.Name("Ref_ExpFastest"), object: nil)
        case .ref_expSlowest: NotificationCenter.default.post(name: Notification.Name("Ref_ExpSlowest"), object: nil)
        case .ref_expiredGoods: NotificationCenter.default.post(name: Notification.Name("Ref_ExpiredGoods"), object: nil)
        case .f_added: NotificationCenter.default.post(name: Notification.Name("F_Added"), object: nil)
        case .f_expFastest: NotificationCenter.default.post(name: Notification.Name("F_ExpFastest"), object: nil)
        case .f_expSlowest: NotificationCenter.default.post(name: Notification.Name("F_ExpSlowest"), object: nil)
        case .f_expiredGoods: NotificationCenter.default.post(name: Notification.Name("F_ExpiredGoods"), object: nil)
        default: break
        }
        
        NotificationCenter.default.post(name: Notification.Name("itemReload"), object: nil)
        delegate?.onTapClose()
        dismiss(animated: true)
    }
    
    
}
