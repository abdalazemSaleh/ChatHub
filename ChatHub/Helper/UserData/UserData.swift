//
//  UserData.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-03.
//

import Foundation

var userKey = "UserKey"

struct UserData {
    static func chacheUserModel(user: UserModel) ->Void {
        let userData = try! user.asDictionary()
        UserDefaults.standard.set(userData, forKey: userKey)
    }
    
    static func getUserModel() -> UserModel? {
        if let cachedData = UserDefaults.standard.object(forKey: userKey) as? [String: Any]{
            let data = try! JSONSerialization.data(withJSONObject: cachedData, options: .prettyPrinted)
            let decoder = JSONDecoder()
            do{
                let user = try decoder.decode(UserModel.self, from: data)
                return user
            }catch{
                return nil
            }
        }
        return nil
    }
    
    static func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: userKey)
        }
    }
}

extension Encodable {
    func asDictionary() throws -> [ String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}


