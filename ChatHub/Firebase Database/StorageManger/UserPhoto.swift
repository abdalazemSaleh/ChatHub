//
//  UserPhoto.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-03.
//

import Foundation
import FirebaseStorage

extension StorageManager {
    // upload user photo to storage
    func uploadUserPhoto(data: Data, fileName: String, completion: @escaping (Result<String, GFError>) -> Void) {
        storage.child("image/\(fileName)").putData(data) { metaData, error in
            guard error == nil else {
                completion(.failure(.failedToUploadPhoto))
                return
            }
            completion(.success("Your photo has been changed succssfuly"))
        }
    }
    
    func downloadUserPhoto(fileName: String, completion: @escaping (Result<String, GFError>) -> Void) {
        storage.child("image/\(fileName)").downloadURL { url, error in
            guard let url = url else {
                completion(.failure(.failedToDownload))
                return
            }
            let URLString = url.absoluteString
            completion(.success(URLString))
        }
    }
}
