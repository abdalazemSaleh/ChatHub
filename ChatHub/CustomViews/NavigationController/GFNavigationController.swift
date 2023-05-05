//
//  GFNavigationController.swift
//  Messenger
//
//  Created by Abdalazem Saleh on 2023-04-29.
//

import UIKit

class GFNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
    }
    
    private func setUpNavigationController() {
        navigationBar.tintColor = UIColor.green
        let mainView = Login()
        self.viewControllers = [mainView]
    }
}
