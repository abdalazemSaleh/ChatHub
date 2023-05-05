//
//  UIViewController.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-04-30.
//

import UIKit
import FirebaseAuth

extension UIViewController {
    func presentTabBar() {
        let tabBar = ChatHubTabBar()
        tabBar.modalPresentationStyle   = .overFullScreen
        tabBar.modalTransitionStyle     = .crossDissolve
        self.present(tabBar, animated: true)
    }
    
    func addNewChatButtonItem() {
        let newChatButton = UIButton(type: .system)
        newChatButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        let newChatButtonItem = UIBarButtonItem(customView: newChatButton)
        newChatButton.addTarget(self, action: #selector(openNewChatVC), for: .touchUpInside)
        navigationItem.rightBarButtonItem = newChatButtonItem
    }
    
    @objc private func openNewChatVC() {
        let vc = SearchForUsersVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
