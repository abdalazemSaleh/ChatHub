//
//  GFError.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-04.
//

import Foundation

enum GFError: Error, LocalizedError {
    case invalidUrl
    case invalidResposeStatus
    case dataTaskError(String)
    
    case failedToUploadPhoto
    case failedToDownload
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("The endpoint URL is invalid", comment: "")
        case .invalidResposeStatus:
            return NSLocalizedString("Error while fetching data please try agine later", comment: "")
        case .dataTaskError(let string):
            return string
        case .failedToUploadPhoto:
            return NSLocalizedString("Some thing went wrong while upload your photo please try agine later.", comment: "")
        case .failedToDownload:
            return NSLocalizedString("Some thing went wrong while download your photo please try agine later.", comment: "")
        }
    }
}
