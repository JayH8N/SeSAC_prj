//
//  HomeViewController.swift
//  BookWorm
//
//  Created by hoon on 2023/09/04.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    
    let addButton = {
        let uibutton = UIButton()
        let buttonImage = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
        let image = UIImage(systemName: "plus.circle", withConfiguration: buttonImage)
        uibutton.setImage(image, for: .normal)
        uibutton.tintColor = .blue
        return uibutton
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "BOOKWORM"
        
        let search = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = search
        
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        configureView()
        setConstraints()
    }
    
    @objc func addButtonClicked() {
        let vc = SearchViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }

    func configureView() {
        
    }
    
    func setConstraints() {
        
    }


}
