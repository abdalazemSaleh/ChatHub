//
//  SceneDelegate.swift
//  Messenger
//
//  Created by Abdalazem Saleh on 2023-04-29.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if Auth.auth().currentUser != nil {
            window?.rootViewController = ChatHubTabBar()
        } else {
            window?.rootViewController = GFNavigationController()
        }
    }
}
