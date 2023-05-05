//
//  ChatHubTabBar.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-04-30.
//

import UIKit

class ChatHubTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .label
        viewControllers = [makeChatsNC(), makeProfileNC()]
    }
    
    private func makeChatsNC() -> UINavigationController {
        let chatVC = ChatVC()
        chatVC.title = "Chats"
        chatVC.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(systemName: "message"), tag: 0)
        return UINavigationController(rootViewController: chatVC)
    }
    
    private func makeProfileNC() -> UINavigationController {
        let profileVC = ProfileVC()
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        return UINavigationController(rootViewController: profileVC)
    }
}
