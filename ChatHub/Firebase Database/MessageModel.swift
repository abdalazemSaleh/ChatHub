//
//  MessageModel.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-05.
//

import UIKit
import MessageKit

/// Message type
struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
/// Sender Type
struct sender: SenderType {
    var senderId: String
    var displayName: String
    var photoUrl: String
}

/// Media item
struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}

/// Message kind
extension MessageKind {
    var messageKind: String {
        switch self {
        case .text(_):
            return "text"
        case .attributedText(_):
            return "attributed_text"
        case .photo(_):
            return "photo"
        case .video(_):
            return "video"
        case .location(_):
            return "location"
        case .emoji(_):
            return "emoji"
        case .audio(_):
            return "audio"
        case .contact(_):
            return "contact"
        case .custom(_):
            return "customc"
        case .linkPreview(_):
            return "link"
        }
    }
}
