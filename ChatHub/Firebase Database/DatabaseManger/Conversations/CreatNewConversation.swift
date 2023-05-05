//
//  CreatNewConversation.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-05.
//

import Foundation

extension DatabaseManger {
    func creatNewConversation(receiverEmail: String, receivername: String, firstMessage: Message, completion: @escaping (Bool) -> Void) {
        guard let currentUser = UserData.getUserModel() else { return }
        
        let child = database.child("\(currentUser.safeEmail)")
        child.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            guard var userNode = snapshot.value as? [String: Any] else {
                completion(false)
                return
            }
            
            let messageDateString = firstMessage.sentDate.dateString
            let message = self.messageKinde(message: firstMessage)
            let conversationId = "conversation_\(firstMessage.messageId)"
            
            /// New conversation data
            let newConversationData: [String: Any] = [
                "id": conversationId,
                "other_user_email": receiverEmail,
                "name": receivername,
                "latest_message": [
                    "date": messageDateString,
                    "message": message as Any,
                    "is_read": false
                ]
            ]
            /// Recipient conversation data
            let recipient_newConversationData: [String: Any] = [
                "id": conversationId,
                "other_user_email": currentUser.safeEmail,
                "name": currentUser.name,
                "latest_message": [
                    "date": messageDateString,
                    "message": message as Any,
                    "is_read": false
                ]
            ]
            
            self.updateRecipientConversationsArry(Conversation: recipient_newConversationData, receiverEmail: receiverEmail, completion: completion)
            
            if var conversations = userNode[self.constant.userConversationsChild] as? [[String: Any]] {
                conversations.append(newConversationData)
                userNode[self.constant.userConversationsChild] = conversations
                child.setValue(userNode) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    self.finshCreatingConversation(name: currentUser.name, conversationId: conversationId, firstMessage: firstMessage, completion: completion)
                }
            } else {
                userNode[self.constant.userConversationsChild] = [
                    newConversationData
                ]
                child.setValue(userNode) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    self.finshCreatingConversation(name: currentUser.name, conversationId: conversationId, firstMessage: firstMessage, completion: completion)
                }
            }
        }
    }

    private func updateRecipientConversationsArry(Conversation: [String: Any], receiverEmail: String, completion: @escaping (Bool) -> Void) {
        database.child("\(receiverEmail)/\(constant.userConversationsChild))").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            if var conversations = snapshot.value as? [[String: Any]]  {
                conversations.append(Conversation)
                self.database.child("\(receiverEmail)/\(self.constant.userConversationsChild)").setValue(conversations) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
            } else {
                self.database.child("\(receiverEmail)/\(self.constant.userConversationsChild)").setValue([Conversation]) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
            }
        }
    }
    
    private func finshCreatingConversation(name: String, conversationId: String, firstMessage: Message, completion: @escaping (Bool) -> Void) {
        
        let messageDateString = firstMessage.sentDate.dateString
        let message = messageKinde(message: firstMessage)
        guard let currentUser = UserData.getUserModel() else { return }
        let userSafeEmail = currentUser.safeEmail
        
        let messageData: [String: Any] = [
            "id": firstMessage.messageId,
            "type": firstMessage.kind.messageKind,
            "content": message,
            "date": messageDateString,
            "sender_email": userSafeEmail,
            "is_read": false,
            "name": name
        ]
        
        let messagesCollection: [String: Any] = [
            "messages": [
                messageData
            ]
        ]
        
        database.child(conversationId).setValue(messagesCollection) { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func messageKinde(message: Message) -> String {
        var firsMessage = ""
        switch message.kind {
        case .text(let messageText):
            firsMessage = messageText
        case .attributedText(_):
            break
        case .photo(let mediaItem):
            if let targetUrlString = mediaItem.url?.absoluteString {
                firsMessage = targetUrlString
            }
            break
        case .video(let mediaItem):
            if let targetUrlString = mediaItem.url?.absoluteString {
                firsMessage = targetUrlString
            }
            break
        case .location(let locationData):
            let location = locationData.location
            firsMessage = "\(location.coordinate.longitude),\(location.coordinate.latitude)"
            break
        case .emoji(_):
            break
        case .audio(_):
            break
        case .contact(_):
            break
        case .linkPreview(_):
            break
        case .custom(_):
            break
        }
        return firsMessage
    }
}

extension Date {
    var dateString: String {
        let formattre = DateFormatter()
        formattre.dateStyle = .medium
        formattre.timeStyle = .long
        formattre.locale = .current
        return formattre.string(from: self)
    }
}
