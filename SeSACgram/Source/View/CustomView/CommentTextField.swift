//
//  CommentTextField.swift
//  SeSACgram
//
//  Created by hoon on 12/4/23.
//

import UIKit
import SnapKit
import Then

final class CommentTextField: UITextField {
    
    let rightButton = UIButton().then {
        $0.tintColor = Constants.Color.DeepGreen
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        $0.setTitle("게시", for: .normal)
        $0.setTitleColor(Constants.Color.DeepGreen, for: .normal)
        $0.titleLabel?.font = Constants.Font.ButtonFont
        $0.isHidden = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        self.tintColor = Constants.Color.DeepGreen
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 0.0))
        self.leftViewMode = .always
        self.layer.cornerRadius = Constants.Size.commentCornerRadius
        self.delegate = self
        self.rightView = rightButton
        rightViewMode = .always
    }
    
}

extension CommentTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderColor = Constants.Color.DeepGreen.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderColor = UIColor.lightGray.cgColor
        rightButton.isHidden = true
    }
}
