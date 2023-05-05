//
//  String.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-04-30.
//

import Foundation

extension String {
    var safeEmail: String {
        var safeEmail = self.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }    
}
