//
//  Case4ViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/23.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

class Case4ViewController: UIViewController {
    
    let mapView = MKMapView()
    
    let locationManager = CLLocationManager()
    
    let currentLocationButton = UIButton()

    
    let sesacLocation = CLLocationCoordinate2D(latitude: 37.51800, longitude: 126.88651) //새싹캠퍼스(37.51800,126.88651), 더현대(37.58667,126.97611)
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "MY MEDIA"
        navigationController?.navigationBar.tintColor = .lightGray
        view.backgroundColor = .white
        locationManager.delegate = self
        
        checkDeviceLocationAuthorization() //사용자의 위치서비스가 활성화 되어있는지 확인
        
        //바아이템
        let filterButton = {
                let button = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked))
                return button
            }()
        navigationItem.rightBarButtonItem = filterButton
        
        
        //객체 세팅 함수
        setMap()
        setCurrentLocationButton(uiButton: currentLocationButton, title: "현재위치", imageName: "target")
        
        
        //annotation
        setAnnotation(type: .all)
        
    }
    
    //MARK: - barButtonItem
    
    @objc func filterButtonClicked() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let megaBox = UIAlertAction(title: "메가박스", style: .default) { _ in
            self.setAnnotation(type: .megabox)
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            self.setAnnotation(type: .lotte)
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            self.setAnnotation(type: .cgv)
        }
        let all = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.setAnnotation(type: .all)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        // 3. alert에 action 붙이기
        alert.addAction(megaBox)
        alert.addAction(lotte)
        alert.addAction(cgv)
        alert.addAction(all)
        alert.addAction(cancel)
        
        // 4. alert present하기
        present(alert, animated: true)
    }
    
    
    
    //MARK: - mapView
    func setMap() {
        
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
    
    func setLocation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
        
        mapView.setRegion(region, animated: true)
    }
    
    func authorizationCurrentLocation() {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    
    //MARK: - 위치권한 활성화여부 체크 함수
    func checkDeviceLocationAuthorization() {
        
        DispatchQueue.global().async {
            //사용자의 위치서비스가 켜져있는지 확인
            if CLLocationManager.locationServicesEnabled() {
                
                //현재 사용자의 위치 권한 상태를 가지고 옴
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
                
            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
            }
        }
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치정보이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
                //print("=====설정으로 이동\(UIApplication.openSettingsURLString)")
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
            //<아직 결정되지 않은 상태>
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //정확도에 대한 설정
            locationManager.requestWhenInUseAuthorization() //Alert(한번 허용, 앱을 사용하는동안 허용, 허용안함)
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            showLocationSettingAlert() //거절 되었을 시 설정화면으로 가도록 유도
            setLocation(center: sesacLocation)
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            authorizationCurrentLocation()
            //locationManager.startUpdatingLocation() //⭐️ 강제로 현재위치 고정시켜버린다.  --> locationManager.stopUpdatingLocation() 사용
        case .authorized:
            print("authorized")
        @unknown default: //후에 위치 권한 종류가 더 생길 가능성 대비
            print("default")
        }
    }
    
    //MARK: - annotation
    func setAnnotation(type: TheaterOption) {
        
        var list: [MKPointAnnotation] = []
        
        
        for i in 0...TheaterList.shared.mapAnnotations.count - 1 {
            let theater = MKPointAnnotation()
            theater.coordinate = CLLocationCoordinate2D(latitude: TheaterList.shared.mapAnnotations[i].latitude, longitude: TheaterList.shared.mapAnnotations[i].longitude)
            theater.title = TheaterList.shared.mapAnnotations[i].location
            theater.subtitle = TheaterList.shared.mapAnnotations[i].type
            
            list.append(theater)
        }
                
        
        switch type {
        case .all:
            mapView.addAnnotations(list)
        case .cgv:
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(list.filter{ $0.subtitle == TheaterOption.cgv.rawValue })
        case .lotte:
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(list.filter{ $0.subtitle == TheaterOption.lotte.rawValue })
        case .megabox:
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(list.filter{ $0.subtitle == TheaterOption.megabox.rawValue })
        }
    }
    
    
    
    //MARK: - 현위치 버튼
    
    func setCurrentLocationButton(uiButton: UIButton, title: String, imageName: String) {
        
        view.addSubview(currentLocationButton)
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30)
        var button = UIButton.Configuration.plain()
        
        button.titleAlignment = .center

        //이미지 삽입
        button.image = UIImage(systemName: imageName)
        button.imagePadding = 4
        button.imagePlacement = .top
        button.preferredSymbolConfigurationForImage = imageConfig
        
        uiButton.configuration = button
        uiButton.tintColor = .red
        
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
        let attributedTitle = NSAttributedString(string: title, attributes: attribute)
        uiButton.setAttributedTitle(attributedTitle, for: .normal)
        
        uiButton.addTarget(self, action: #selector(currentLocationButtonClicked), for: .touchUpInside)
        
        
        currentLocationButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view).offset(-4)
        }
    }
    
    @objc
    func currentLocationButtonClicked() {
        checkDeviceLocationAuthorization()
    }
    
    
    
    
}




//MARK: - extension
extension Case4ViewController: CLLocationManagerDelegate {
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            setLocation(center: coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "위치정보이용 불가", message: "위치 서비스를 사용할 수 없습니다. 다시시도해주세요", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    
    //권한이 바뀔때마다 호출되는 함수
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
    
    
}
