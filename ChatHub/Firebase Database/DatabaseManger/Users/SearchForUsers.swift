//
//  SearchForUsers.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-03.
//

import FirebaseDatabase

extension DatabaseManger {
    func searchForuser(completion: @escaping ([[String: String]]) -> Void) {
        database.child(constant.usersCollectionChild).observeSingleEvent(of: .value) { snapshot in
            guard let usersCollection = snapshot.value as? [[String: String]] else {
                return
            }
            completion(usersCollection)
        }
    }
}


