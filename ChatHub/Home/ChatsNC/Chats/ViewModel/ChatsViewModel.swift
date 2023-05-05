//
//  ChatsViewModel.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-03.
//

import Foundation

class ChatViewModel {
    // MARK: - Variables
    private var chats: [ChatModel] = []
    private var filteredChats: [ChatModel] = []
    
    private var isSearching: Bool = false
    
    init() {
        chats = [.init(name: "Mohamed"), .init(name: "Ahmed"), .init(name: "Hussein")]
    }
    
    // MARK: - Functions
    func getChats() -> [ChatModel] {
        return chats
    }
    
    func searchForChat(_ filter: String) -> [ChatModel] {
        guard !filter.isEmpty else {
            filteredChats.removeAll()
            isSearching = false
            return chats
        }
        isSearching = true
        filteredChats = chats.filter { $0.name.lowercased().contains(filter.lowercased()) }
        return filteredChats
    }
}
