//
//  DetailViewController.swift
//  BookWorm
//
//  Created by hoon on 2023/09/05.
//

import UIKit
import RealmSwift


class DetailViewController: BaseViewController {
    
    let repository = BookTableRepository()
    
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
        view.backgroundColor = UIColor(red: 143/255, green: 190/255, blue: 235/255, alpha: 1)
        
        let edit = UIBarButtonItem(customView: editButton)
        navigationItem.rightBarButtonItem = edit
        navigationController?.navigationBar.tintColor = .blue
        
        editButton.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
        
        
        mainView.saveButtonImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(saveButtonTapped))
        mainView.saveButtonImage.addGestureRecognizer(tap)
    }
    
    @objc func saveButtonTapped() {
        guard let data = data else { return }
        
        
    }
    
    
    
    
    @objc func editButtonClicked() {
        
        guard let data = data else { return }
//        let task = BookTable(value: ["_id": data._id, "bookAuthor": data.bookAuthor ,"bookTitle": data.bookTitle, "memo": mainView.textView.text])
//
//        do {
//            try realm.write {
//                realm.add(task, update: .modified)
//            }
//        } catch {
//            print("") // NSlog
//        }
        
        repository.updateItem(id: data._id, memoText: mainView.textView.text)
        
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
