//
//  StorageManger.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-03.
//

import FirebaseStorage

class StorageManager {
    // MARK: - Variables
     static let shared = StorageManager()
     let storage = Storage.storage().reference()
}

