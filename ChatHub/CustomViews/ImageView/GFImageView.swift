//
//  GFImageView.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-04.
//

import UIKit

class GFImageView: UIImageView {

    let images = Images.shared
    
    let activityIndicator = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        activityIndicator.startAnimating()
    }
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                    self.activityIndicator.stopAnimating()
                }
            } else {
                self.setImptyPhoto()
            }
        }.resume()
    }
    
    func setImptyPhoto() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.image = self.images.emptyUserPhoto
        }
    }
}
