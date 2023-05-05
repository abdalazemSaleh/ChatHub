//
//  UserCell.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-03.
//

import UIKit

class UserCell: UITableViewCell {
        
    // MARK: - IBOutlet
    @IBOutlet weak var userImage: GFImageView!
    @IBOutlet weak var userName: UILabel!
    
    // MARK: - Initilizer
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    // MARK: - Set function
    func set(user: UserModel) {
        userName.text = user.name
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.clipsToBounds = true
        
        let file = user.profilePictureFileName
        getPictureURL(from: file)
    }
        
    private func getPictureURL(from fileName: String) {
        StorageManager.shared.downloadUserPhoto(fileName: fileName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let url):
                guard let url = URL(string: url) else{ return }
                self.userImage.loadImage(from: url)
            case .failure(_):
                self.userImage.setImptyPhoto()
            }
        }
    }
}
