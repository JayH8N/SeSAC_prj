//
//  NSMutableAttributedString + Extension.swift
//  BookWorm
//
//  Created by hoon on 2023/09/06.
//

import UIKit

extension NSMutableAttributedString {

    func appendImage(image: UIImage, bounds: CGRect) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = bounds
        self.append(NSAttributedString(attachment: imageAttachment))
    }
    
    func insertImage(image: UIImage, bounds: CGRect, at: Int) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = bounds
        self.insert(NSAttributedString(attachment: imageAttachment), at: at)
    }
    
}
