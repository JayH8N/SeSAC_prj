//
//  SearchBarCustom.swift
//  Recap_2
//
//  Created by hoon on 2023/09/08.
//

import UIKit

class SearchBarCustom: UISearchBar {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  
    func setView() {
        searchTextField.textColor = .white //서치바 Input textColor 변경
        barTintColor = .clear //서치바 바깥영역컬러
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchTextField.backgroundColor = CustomColor.feildBGColor
        searchTextField.leftView?.tintColor = CustomColor.feildItemColor
        setImage(UIImage(systemName: "x.circle.fill"), for: .clear, state: .normal)
        
        //cancelButton Custom
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "취소"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.white
        
        //clearbutton color 변경
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.clearButtonMode = .whileEditing
            textField.tintColor = CustomColor.feildItemColor
        }
        
    }
    
}
