//
//  BaseVC.swift
//  SeSAC_Talk
//
//  Created by hoon on 1/3/24.
//

import UIKit

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    func configureView() { }
    
    func setConstraints() { }
    
    enum Detent {
        case large
        case medium
        case custom(CGFloat)
    }
    
    func createBottomSheet(vc: BaseVC, detent: Detent) {
        guard let bottomSheet = vc.sheetPresentationController else { return }
        
        var height: UISheetPresentationController.Detent {
            switch detent {
            case .large:
                return .large()
            case .medium:
                return .medium()
            case .custom(let cGFloat):
                return .custom { _ in
                    cGFloat
                }
            }
        }
        
        bottomSheet.preferredCornerRadius = 10
        bottomSheet.detents = [height]
        bottomSheet.prefersGrabberVisible = true
        
        self.present(vc, animated: true)
    }
}
