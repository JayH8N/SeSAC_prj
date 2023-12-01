//
//  CustomTextView.swift
//  SeSACgram
//
//  Created by hoon on 12/1/23.
//

import UIKit
import SnapKit
import Then

final class CustomTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.delegate = self
        self.tintColor = Constants.Color.DeepGreen
        self.layer.cornerRadius = Constants.Size.textFieldCornerRadius
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.font = .systemFont(ofSize: 17)
        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
    }
}

extension CustomTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        layer.borderColor = Constants.Color.DeepGreen.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
//    // 텍스트뷰 높이 동적으로 조절
//    func textViewDidChange(_ textView: UITextView) {
//        updateTextViewHeight()
//    }
//
//    private func updateTextViewHeight() {
//        let fixedWidth = self.frame.size.width
//        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//
//        // 최소 높이, 최대 높이
//        let minHeight: CGFloat = 130
//        let maxHeight: CGFloat = 200
//
//        let newHeight = max(minHeight, min(newSize.height, maxHeight))
//
//        self.bounds.size = CGSize(width: fixedWidth, height: newHeight)
//    }
}

