//
//  SearchForUserViewModel.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-03.
//

import Foundation

class SearchForUsersViewModel {
    
    // MARK: - Variables()
    private let database = DatabaseManger.shared
    
    private var users = [[String: String]]()
    private var mapedUsers = [UserModel]()
    private var filteredUsers = [UserModel]()
    
    private var isSearching = Bool()
    
    // MARK: - Demeter functions
    func getUsers() -> [UserModel] {
        return mapedUsers
    }
    
    // MARK: - Functions
    func fetchUsers(completion: @escaping ([UserModel]) -> Void) {
        database.searchForuser { [weak self] users in
            guard let self = self else { return }
            self.users = users
            self.mapedUsers = users.map { dict in
                return UserModel(name: dict["name"] ?? "", emailAddress: dict["email"] ?? "")
            }
            completion(self.mapedUsers)
        }
    }
    
    func searchForUser(_ filter: String) -> [UserModel] {
        guard !filter.isEmpty else {
            filteredUsers.removeAll()
            isSearching = false
            return mapedUsers
        }
        isSearching = true
        filteredUsers = mapedUsers.filter { $0.name.lowercased().contains(filter.lowercased()) }
        return filteredUsers
    }
}
