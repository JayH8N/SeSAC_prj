//
//  FoodsExDateCell.swift
//  Pantry
//
//  Created by hoon on 2023/10/16.
//

import UIKit
import Then

class FoodsExDateCell: BaseTableViewCell {
    
    var selectedDate: Date?
    
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .compact
        $0.tintColor = UIColor.brown.withAlphaComponent(0.7)
    }
    
    
    
    
    
    override func configureView() {
        
        //Locale설정
        if let preferLocale = Locale.preferredLanguages.first {
            datePicker.locale = Locale(identifier: preferLocale)
        }
        
        
        selectionStyle = .none
        textLabel?.text = NSLocalizedString("Expiry date", comment: "")
        
        datePicker.addTarget(self, action: #selector(datePickerPickedValue), for: .valueChanged)
        
        accessoryView = datePicker
    }
    
    
    
    override func setConstraints() {
        
    }
    
    
    @objc func datePickerPickedValue() {
        self.selectedDate = datePicker.date
        
    }
    
    
    
}
