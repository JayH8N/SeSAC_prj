//
//  DateViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/29.
//

import UIKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    //💡2. 값전달
    var delegate: PassDataDelegate?
    
    
    
    override func loadView() {
        self.view = mainView
    }
    
    
    
    //💡3.Protocol 값전달(어느 시점에 데이터를 전달할건지)
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate?.receiveDate(date: mainView.picker.date)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func configureView() {
        super.configureView()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    
    
    
    
    
    
    
}
