//
//  ChatsCell.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-03.
//

import UIKit

class ChatsCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var messageDate: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    
    // MARK: - Functions
    func set(_ chat: ChatModel) {
        userName.text = chat.name
    }    
}
