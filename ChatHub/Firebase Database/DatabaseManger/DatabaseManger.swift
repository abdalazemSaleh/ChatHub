//
//  DatabaseManger.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-04-30.
//

import FirebaseDatabase

class DatabaseManger {
    // Shared instance of class
    public static let shared = DatabaseManger()
    // get refrance from my database
    public let database = Database.database().reference()
    //
    let constant = Constant.shared
}
