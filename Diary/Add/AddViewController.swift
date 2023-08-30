//
//  ViewController.swift
//  Diary
//
//  Created by hoon on 2023/08/28.
//

import UIKit
import SeSACPhotoFramework

//💡1.값전달
protocol PassDataDelegate {
    func receiveDate(date: Date)
}
//💡💡1.값전달
protocol PassImageDataDelegate {
    func receiveImage(image: UIImage)
}

class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super메서드 호출 X(내가 직접 커스텀한 뷰를 루트뷰로 하는거라서, 만약 super호출하면 애플이 지정한 뷰가 루트뷰가 됨)
        self.view = mainView
    }
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //⌘커스텀 프레임워크
        ClassOpenExample.publicExample() //
        ClassPublicExample.publicExample() //
        //ClassInternalExample.internalExample() //프레임워크에서 class앞에 아무것도 정의되어 있지 않아 import해도 접근이 불가능하다.
        
        //2️⃣값전달.
        //NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
        APIServie.shared.callRequest()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
        
        
        sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
    }
    
    
    //3️⃣값전달.
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        //print(notification.userInfo?["name"])
        //print(notification.userInfo?["sample"])
        
        print(#function)
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        let word = ["Apple", "Banana", "cookie", "Cake", "Sky"]
        
        NotificationCenter.default.post(name: NSNotification.Name("RecommandKeyword"), object: nil, userInfo: ["word": word.randomElement()! ])
        
        present(SearchViewController(),animated: true)
        //navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    //addSubView
    override func configureView() {
        super.configureView()
        print("Add ConfigureView")
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.contentButton.addTarget(self, action: #selector(textButtonClicked), for: .touchUpInside)
        APIServie.shared.callRequest()
    }
    
    @objc func searchProtocolButtonClicked() {
        //💡💡5.값전달
        let vc = SearchViewController()
        vc.delegate = self
        
        present(vc, animated: true)
    }
    
    @objc func dateButtonClicked() {
        //💡5.값전달
        let vc = DateViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonClicked() {
        let vc = TitleViewController()
        
        //✅3. 클로저 값전달
        vc.completionHandler = { a in
            self.mainView.titleButton.setTitle(a, for: .normal)
            print("completionHandler")
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textButtonClicked() {
        let vc = TextViewController()
        vc.completionHandler = { title, age, bool in
            print("클로저 값전달 : \(age), \(bool)")
            self.mainView.contentButton.setTitle(title, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //제약조건
    override func setConstraints() {
        super.setConstraints()
        print("Add SetConstraints")
    }
    

}

//💡4.값전달
extension AddViewController: PassDataDelegate {
    
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

//💡💡4.값전달
extension AddViewController: PassImageDataDelegate {
    
    func receiveImage(image: UIImage) {
        mainView.photoImageView.image = image
    }
}
