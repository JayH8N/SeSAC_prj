//
//  DocumentManager.swift
//  Recap_2
//
//  Created by hoon on 2023/09/10.
//

import UIKit

class DocumentManager {
    
    static let shared = DocumentManager()
    
    private init() { }
    
    //이미지 삭제
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
    
    
    //이미지 가져오기
    func loadImageFromDocument(fileName: String) -> UIImage {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "questionmark.square.dashed")! }
        
        //2. 경로 설정(세부 경로, 이미지를 저장할 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)! //존재할 경우
        } else {
            return UIImage(systemName: "questionmark.square.dashed")! //존재하지 않을 경우
        }
    }
    
    
    //이미지 저장하기
    func saveImageToDocument(fileName: String, image: UIImage) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }//jpeg와 png가 있음, jpeg는 압축률 지정가능
        
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
        
    }

    
}
