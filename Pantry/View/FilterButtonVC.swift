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
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
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
    
    
    static func instance() -> FilterButtonVC {
        return FilterButtonVC(nibName: nil, bundle: nil).then {
            $0.modalPresentationStyle = .overFullScreen
        }
    }
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = NSLocalizedString("SelectSort", comment: "")
    }
    
    override func configureView() {
        view.backgroundColor = .clear
        view.addSubview(bgView)
        bgView.addSubview(blurEffect)
        bgView.addSubview(titleLabel)
        
        cancelButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        applyButton.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)
        
        bgView.addSubview(buttonStackView)
    }
    
    
    
    override func setConstraints() {
        bgView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-40)
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        
        blurEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.top.equalToSuperview().inset(30)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(bgView.snp.height).multipliedBy(0.13)
            $0.bottom.equalTo(bgView.snp.bottom).inset(20)
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
