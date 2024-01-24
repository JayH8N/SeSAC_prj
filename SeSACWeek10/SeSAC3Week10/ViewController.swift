//
//  ViewController.swift
//  SeSAC3Week10
//
//  Created by hoon on 2023/09/19.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    let viewModel = ViewModel()

    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green
        view.minimumZoomScale = 1 //줄여도 1배수로 돌아옴
        view.maximumZoomScale = 4 //최대 4배수까지 커짐
        view.showsVerticalScrollIndicator = false //스크롤뷰 indicator 보이지 않도록
        view.showsHorizontalScrollIndicator = false //스크롤뷰 indicator 보이지 않도록
        view.delegate = self
        return view
    }()
    
    
    private let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureGesture()
        
        viewModel.request { url in
            self.imageView.kf.setImage(with: url) //vc에서는 이미지를 보여주기만 하고 있다.
        }
        
        //request(query: "apple")
        //random()
        //"wExSfWSHNwA"
        
//        NetworkBasic.shared.random { photo, error in
//            //옵셔널 바인딩 필요함
//            guard let photo = photo else { return }
//            dump(photo)
//        }

        //Result타입 대응
//        NetworkBasic.shared.detailPhoto(id: "wExSfWSHNwA") { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                //네트워크 실패 대응
//                print(failure)
//            }
//        }
        
       
        
    }
    

    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2 //몇번의 탭을 할건지
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    
    private func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
    }
    
    func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    
    
    
    
}


extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}


//Codable : Decodable + Encodable
//Decodable => Json을 받아와 사용할 수 있도록 변환
//받아오는 구조가 같다면 모델 재사용 가능
struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let created_at: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}
