//
//  CommentVC.swift
//  SeSACgram
//
//  Created by hoon on 12/4/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

struct Test {
    let nickName: String
    let comment: String
}

final class CommentVC: BaseVC {
    
    var list: [Test] = [
        Test(nickName: "Jack", comment: "ㅎㅇㅎㅇㅎㅇㅎㅇ"),
        Test(nickName: "Koko", comment: "안녕하세요"),
        Test(nickName: "Hue", comment: "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"),
        Test(nickName: "Bran", comment: "보드타고 싶다....."),
        Test(nickName: "ㅇㅈㅎ", comment: "#######################################"),
        Test(nickName: "ㅇㅈㅇ", comment: "ㅎㅇㅎㅇ"),
        Test(nickName: "ㅂㄱㅇ", comment: "&&&&&&&&&&&&&&&&&&&&&&&&&"),
        Test(nickName: "ㅂㄷㅎ", comment: "각박한 세상..."),
        Test(nickName: "popo", comment: "hi hi hi hi"),
        Test(nickName: "ronaldo", comment: "siuuuuuuuuuuuuuuuuuuuuuuuu")
    ]
    
    private let disposeBag = DisposeBag()
    private let comment = PublishSubject<String>()
    
    private let mainView = CommentView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.commentTableView.delegate = self
        mainView.commentTableView.dataSource = self
        addTargets()
        bind()
    }
    
    override func setNavigationBar() {
        self.title = "댓글"
        navigationController?.navigationBar.layer.addBorder([.bottom], width: 0.3, color: Constants.Color.DeepGreen.cgColor)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Constants.Color.AppearanceModal
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func bind() {
        comment
            .bind(to: mainView.commentTextField.rx.text)
            .disposed(by: disposeBag)
        
        let isValid = mainView.commentTextField
            .rx
            .text
            .orEmpty
            .map { $0.count > 0 } //텍스트 존재시 true
        
        isValid
            .subscribe(with: self) { owner, value in
                owner.updateUI(isValue: value)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateUI(isValue: Bool) {
        mainView.commentTextField.rightButton.isHidden = !isValue
    }
    
    
}

extension CommentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell().description, for: indexPath) as! CommentTableViewCell
        
        cell.setCell(data: target)
        
        return cell
    }

}

//위로 스크롤 할때만 키보드 내리기
extension CommentVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yValue = mainView.commentTableView.contentOffset.y
        if yValue < 0 {
            mainView.commentTextField.resignFirstResponder()
        }
    }
}

extension CommentVC: AddTargetProtocol {
    func addTargets() {
        mainView.refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        mainView.commentTextField.rightButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
    }
    
    @objc private func postButtonTapped() {
        mainView.commentTextField.resignFirstResponder()
        //api요청, tableView reloadData
    }
    
    @objc private func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            //api요청 후 reloadData
            self.mainView.refresh.endRefreshing()
        }
    }
}
