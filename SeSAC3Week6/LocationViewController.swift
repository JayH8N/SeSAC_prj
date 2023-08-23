//
//  LocationViewController.swift
//  SeSAC3Week6
//
//  Created by hoon on 2023/08/22.
//

import UIKit
import CoreLocation //1. 위치 임포트
import MapKit //🗾1.임포트 MapKit
import SnapKit

class LocationViewController: UIViewController {
    
    let cafeButton = UIButton()
    let foodButton = UIButton()
    
    
    //2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    //🗾2.임포트 Map인스턴스 생성
    let mapView = MKMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //🗾3.subView추가
        view.addSubview(mapView)
        //🗾4.snapKit설정
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(40)
        }
        let center = CLLocationCoordinate2D(latitude: 37.51800, longitude: 126.88651)
        setRegionAndAnnotation(center: center)
        
        
        //버튼
        view.addSubview(cafeButton)
        cafeButton.addTarget(self, action: #selector(cafeButtonClicked), for: .touchUpInside)
        cafeButton.backgroundColor = .red
        cafeButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.size.equalTo(50)
            make.leading.equalTo(view).offset(100)
        }
        view.addSubview(foodButton)
        foodButton.backgroundColor = .blue
        foodButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.size.equalTo(50)
            make.trailing.equalTo(view).offset(-100)
        }
        
        
        
        
        //
        view.backgroundColor = .white
        
        
        
        //3. 위치 프로토콜 연결
        locationManager.delegate = self
        
        
        //info.plist << 얼럿
        //locationManager.requestWhenInUseAuthorization() //info에서 wheninuseDescription에 문구를 기입했기에 같은 메서드 선택해야된다.
        //1️⃣-사용자의 위치서비스가 활성화 되어있는지 확인
        checkDeviceLocationAuthorization()
        
        
        
        
        setAnnotation(type: 0)
    }
    
    @objc func cafeButtonClicked() {
        setAnnotation(type: 1)
        print("잘찍")
    }
    
    
    
    //Annotation
    func setAnnotation(type: Int) {

        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 37.517857, longitude: 126.886714) //컴포즈
        
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 37.517746, longitude: 126.887131) //오밥
        
        
        if type == 0 {
            mapView.addAnnotations([annotation1, annotation2])
        } else if type == 1 {
            
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([annotation2])
        }
    }
    
    
    //🗾5.mapView설정
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        //지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
        
        mapView.setRegion(region, animated: true)
        
        
        //지도 어노테이션 추가
        let annotation = MKPointAnnotation()
        annotation.title = "영캠이에요"
        annotation.coordinate = center
        
        mapView.addAnnotation(annotation)
    }
    
    //위치권한 거부시 설정화면 가도록 유도하는 함수
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치정보이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        
        //설정에서 직접적으로 앱 설정 화면에 들어간적이 없다면
        //한번도 설정 앱에 들어가지 않았거나, 막 다운받은 앱이라서
        //설정 페이지로 넘어갈지, 설정 상세 페이지 결정 못한다.
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
    
    
    
    //2️⃣, 5️⃣
    func checkDeviceLocationAuthorization() {
        print("=====1")
        
        //iOS 위치 서비스 활성화 체크
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
                
                print(authorization)
                
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
                
            } else {
                //Alert으로 대응
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
            }
        }
    }
    
    
    //3️⃣, 6️⃣
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("check", status)
        
        switch status {
        //<아직결정이 되지 않은상태>
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //정확도에 대한 설정
            locationManager.requestWhenInUseAuthorization() //alert(한번 허용, 앱을 사용하는 동안 허용, 허용안함)을 띄워줌, ⚠️infoplist에서 설정해야 alert이 잘뜸
            
        //Alert에서 선택시 권한 변경됨
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            showLocationSettingAlert()
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            //didUpdatelocation 메서드 실행
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default: //위치 권한 종류가 더 생길 가능성 대비(애플이 추후 업데이트 할 경우 대비)
            print("default")
        }
    }
   

}












//4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate {

    //(didUpdate)
    //5. 사용자의 위치를 성공적으로 가지고 온 경우 //한번만 실행되지 않는다.(위치가 바뀔때마다 계속 실행된다 + iOS위치 업데이트가 필요한 시점에 알아서 여러번 호출된다.)
    //7️⃣
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //✔️전체정보
        //print("====",locations)
        
        
        //✔️위도,경도값
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        
        
        
        //계속 호출되는거 막고 싶을 때, 한번만 위치업데이트 하고싶을 때
        //베터리, 발열문제를 야기시킬 수 있는것 방지(ex: 달리는 경우 위치가 계속 업데이트되면 didUpdateLocations함수가 지속적으로 호출될 수 있음)
        locationManager.stopUpdatingLocation()
    }


    //(didFailWith))
    //6.사용자의 위치를 가지고 오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

    //(didchangeAuthorization)
    //사용자의 권한 상태가 바귈 때를 알려줌
    //거부했다가 설정에서 변경을 했거나, 혹은 noDeermined상태에서 허용을 했거나, 허용해서 위치를 가지고 오는 도중에, 설정에서 거부를 하고 앱으로 다시 돌아올 때 등
    //iOS14이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //4️⃣권한이 바뀌면 자동으로 호출된다.
        print(#function, "권한 바뀔 때 신호주는 함수")
        checkDeviceLocationAuthorization()
    }

    //(didchangeAuthorization)
    //iOS14미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
    }
}









//🗾map
extension LocationViewController: MKMapViewDelegate {
    
    //지도를 움직이다 멈추면 호출되는 함수
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
    
    //지도 일부분을 선택할 때 호출되는 함수
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }
    
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print(#function)
//    }
    
    
    
}
