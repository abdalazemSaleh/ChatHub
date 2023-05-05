//
//  CreatUser.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-04-30.
//

import FirebaseDatabase

extension DatabaseManger {
    func creatNewUser(userModel: UserModel, completion: @escaping (Bool) -> Void) {
        let user = [
            "name": userModel.name
        ]
                
        database.child(userModel.safeEmail).observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            if snapshot.exists() {
                completion(true)
            } else {
                self.database.child(userModel.safeEmail).setValue(user) { [weak self] error, _ in
                    guard let self = self else { return }

                    guard error == nil else {
                        completion(false)
                        return
                    }

                    self.addUserIntoUsersArray(userModel: userModel) { success in
                        guard success else {
                            completion(false)
                            return
                        }
                        completion(true)
                    }
                }
            }
        }
    }
        
    private func addUserIntoUsersArray(userModel: UserModel, completion: @escaping (Bool) -> Void) {
        database.child(constant.usersCollectionChild).observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            
            if var usersCollection = snapshot.value as? [[String: String]] {
                let newUser = [
                    "name": userModel.name,
                    "email": userModel.safeEmail
                ]
                usersCollection.append(newUser)
                
                self.addNewUserToUsersCollection(newUser: usersCollection) { success in
                    guard success else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
            } else {
                self.creatUsersCollection(userModel: userModel) { success in
                    guard success else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
            }
        }
    }
        
    private func addNewUserToUsersCollection(newUser: [[String: String]], completion: @escaping (Bool) -> Void) {
        database.child(constant.usersCollectionChild).setValue(newUser) { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    private func creatUsersCollection(userModel: UserModel, completion: @escaping (Bool) -> Void) {
        let usersColletion: [[String: String]] = [[
            "name": userModel.name,
            "email": userModel.emailAddress
        ]]
        
        database.child(constant.usersCollectionChild).setValue(usersColletion) { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
