//
//  BottomSheetVC.swift
//  SeSACgram
//
//  Created by hoon on 11/27/23.
//

import UIKit
import SnapKit
import Then

final class BottomSheetVC: BaseVC {
    
    weak var modalDelegate: ModalDelegate?
    weak var pushDelegate: PushableTransition?
    
    private let mainView = BottomSheetView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenuTapGesture()
    }
    
    static func instance() -> BottomSheetVC {
        return BottomSheetVC(nibName: nil, bundle: nil).then {
            $0.modalPresentationStyle = .overFullScreen
        }
    }

}

//TapGesture
extension BottomSheetVC {
    private func setMenuTapGesture() {
        let modalDismiss = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        mainView.addGestureRecognizer(modalDismiss)
        let personalMenuList = UITapGestureRecognizer(target: self, action: #selector(firstMenuTapped))
        mainView.settingAndPersonalMenu.addGestureRecognizer(personalMenuList)
    }
    
    //modalView dismiss
    @objc private func viewTapped() {
        modalDelegate?.onTapClose()
        dismiss(animated: true, completion: nil)
    }
    //설정 및 개인정보
    @objc private func firstMenuTapped() {
        modalDelegate?.onTapClose()
        self.dismiss(animated: true) {
            let vc = SetPersonalVC(title: "설정 및 개인정보")
            self.pushDelegate?.push(vc: vc)
        }
    }
}

