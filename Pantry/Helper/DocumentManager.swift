//
//  DocumentManager.swift
//  Pantry
//
//  Created by hoon on 2023/10/04.
//

import UIKit


class DocumentManager {
    
    static let shared = DocumentManager()
    
    private init() { }
    
    //테이블뷰 셀 삭제시 Document폴더에 이미지는 삭제 되지 않는다.
    //이미지 삭제 메서드
    func removeImageFromDocument(fileName: String) {
        //1.도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        //2. 경로 설정(세부 경로, 이미지를 저장할 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
    
    
    
    //도큐먼트 폴더에서 이미지를 가져오는 메서드
    func loadImageFromDocument(fileName: String) -> UIImage {
        
        //1.도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(named: "basicRefiger")! }
        
        //2. 경로 설정(세부 경로, 이미지를 저장할 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)! //존재할 경우
        } else {
            return UIImage(systemName: "star.fill")! //존재하지 않을 경우
        }
    }
    
    
    
    //document폴더에 이미지 저장 메서드
    func saveImageToDocument(fileName: String, image: UIImage) {
        //1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //2. 저장할 경로 설정(세부 경로, 이미지를 저장할 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        //3. 이미지 변환
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }//jpeg와 png가 있음, jpeg는 압축률 지정가능
        
        //4. 이미지 저장
        do {
            try data.write(to: fileURL) //데이터를 사용해야 될때면 try구문 사용
        } catch let error {
            print("file save error", error)
        }
    }
    
}
