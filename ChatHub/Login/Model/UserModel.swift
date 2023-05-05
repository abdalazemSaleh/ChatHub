//
//  UserModel.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-04-30.
//

import Foundation

struct UserModel: Codable, Hashable {
    let name: String
    let emailAddress: String
    var safeEmail: String {
        return emailAddress.safeEmail
    }
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
}
