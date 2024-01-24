//
//  MovieInfoViewController.swift
//  BOOKWARM
//
//  Created by hoon on 2023/07/31.
//

import UIKit

enum TransitionType {
    case push
    case present
}

class MovieInfoViewController: UIViewController {
    
    static let identifier = "MovieInfoViewController"
    let placeholderText = "내용을 입력부탁드립니다."
    
    
    var type: TransitionType = .push
    
    var Poster: String = ""
    var mTitle: String = ""
    var overview: String = ""
    
    var movieRate: Double = 0.0
    var rTime: Int = 0
    var rDate: String = ""
    
    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieInformation: UILabel!
    @IBOutlet var movieOverview: UITextView!


    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        textView.text = placeholderText
        textView.textColor = .black
        textView.backgroundColor = .systemGreen
        
        //화면전환 조건에 따른 분류
        switch type {
        case .present:
            let xmark = UIImage(systemName: "xmark")
            navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
            navigationItem.leftBarButtonItem?.tintColor = .red
            
        case .push: print("")
        }
        
        //값전달
        moviePoster.image = UIImage(named: Poster)
        movieInformation.numberOfLines = 0
        movieInformation.text = #" \#(mTitle) \#n \#(movieRate)점 \#n \#(rTime)분 \#n \#(rDate)"#
        movieOverview.text = overview
    }
    
    @objc
    func closeButtonClicked(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
        
    }
    
    @IBAction func tpaGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

    func setCell(data: Movie) {
        Poster = data.image
        mTitle = data.title
        overview = data.overview
        movieRate = data.rate
        rTime = data.runtime
        rDate = data.releaseDate
    }
}


extension MovieInfoViewController: UITextViewDelegate {
    //커서가 시작될때(편집이 시작될 때)
    //플레이스 홀더와 텍스트뷰 글자가 같다면 clear, color/
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝날 때(커서가 없어지는 순간)
    //사용자가 아무 글자도 안썼으면 플레이스홀더 글자 보이게 설정!
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .black
            textView.font = UIFont.boldSystemFont(ofSize: 13)
        }
    }
}
