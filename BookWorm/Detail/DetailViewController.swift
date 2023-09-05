//
//  DetailViewController.swift
//  BookWorm
//
//  Created by hoon on 2023/09/05.
//

import UIKit


class DetailViewController: BaseViewController {
    
    let mainView = DetailView()
    
    var data: BookTable?
    
    let editButton = {
        let view = UIButton()
        view.setTitle("수정", for: .normal)
        view.setTitleColor(UIColor.blue, for: .normal)
        return view
    }()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edit = UIBarButtonItem(customView: editButton)
        navigationItem.rightBarButtonItem = edit
    }
    
    
    
    
    override func configureView() {
        super.configureView()
        
        
        guard let data = data else { return }
        mainView.titleLabel.text = data.bookTitle
        mainView.image.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
    }
    
    
    
    override func setConstraints() {
        super.setConstraints()
    }
}
