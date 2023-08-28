//
//  ViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/28.
//

import UIKit

class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super메서드 호출 X(내가 직접 커스텀한 뷰를 루트뷰로 하는거라서, 만약 super호출하면 애플이 지정한 뷰가 루트뷰가 됨)
        self.view = mainView
    }
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2️⃣값전달.
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
        
    }
    
    //3️⃣값전달.
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print("select")
        print(notification.userInfo?["name"])
        print(notification.userInfo?["sample"])
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        let word = ["Apple", "Banana", "cookie", "Cake", "Sky"]
        
        NotificationCenter.default.post(name: NSNotification.Name("RecommandKeyword"), object: nil, userInfo: ["word": word.randomElement()! ])
        
        present(SearchViewController(),animated: true)
    }
    
    //addSubView
    override func configureView() {
        super.configureView()
        print("Add ConfigureView")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    
    //제약조건
    override func setConstraints() {
        super.setConstraints()
        print("Add SetConstraints")
    }
    
    
    
    
    
    


}

