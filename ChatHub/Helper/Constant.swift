//
//  Constant.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-04-30.
//

import UIKit

struct Constant {
    static let shared = Constant()
    let usersCollectionChild = "users"
    let userConversationsChild = "conversations"
    
    let chatCellNibName = "ChatsCell"
    let userCellNib = "UserCell"
}

struct Images {
    static let shared = Images()
    
    let emptyUserPhoto = UIImage(systemName: "person.circle.fill")
    
}
