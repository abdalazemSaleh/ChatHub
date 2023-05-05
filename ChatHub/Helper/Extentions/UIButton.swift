//
//  UIButton.swift
//  Messenger
//
//  Created by Abdalazem Saleh on 2023-04-29.
//

import UIKit

extension UIButton {
    func configureLoginButtonStyle() {
        self.layer.cornerRadius = 28
        self.layer.borderWidth  = 2
        self.layer.borderColor  = UIColor.label.cgColor
    }
}
