//
//  DetailViewController.swift
//  BookWorm
//
//  Created by hoon on 2023/09/05.
//

import UIKit
import RealmSwift


class DetailViewController: BaseViewController {
    
    let mainView = DetailView()
    let realm = try! Realm()
    
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
        
        editButton.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
    }
    
    @objc func editButtonClicked() {
        
        guard let data = data else { return }
        let task = BookTable(value: ["_id": data._id, "bookAuthor": data.bookAuthor ,"bookTitle": data.bookTitle, "memo": mainView.textView.text])
        
        do {
            try realm.write {
                realm.add(task, update: .modified)
            }
        } catch {
            print("") // NSlog
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    override func configureView() {
        super.configureView()
        
        
        guard let data = data else { return }
        mainView.titleLabel.text = data.bookTitle
        mainView.image.image = DocumentManager.shared.loadImageFromDocument(fileName: "JH\(data._id)")
        mainView.textView.text = data.memo
    }
    
    
    
    override func setConstraints() {
        super.setConstraints()
    }
}
