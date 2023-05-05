//
//  ImageDownloader.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-03.
//

import UIKit

struct ImageDownloader {
    let url: URL?
        
    func downloadImageFromUrlAndReturnData(completion: @escaping (Result<Data, GFError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
