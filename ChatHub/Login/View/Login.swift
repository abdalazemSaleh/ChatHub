//
//  Login.swift
//  Messenger
//
//  Created by Abdalazem Saleh on 2023-04-29.
//

import UIKit

class Login: UIViewController {
    // MARK: - Variables
    let viewModel = LoginModelView()
    
    // MARK: - IBOutlet
    @IBOutlet weak var appTitle: UILabel!
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        configureAppTitle()
    }

    // MARK: - IBActions
    
    @IBAction func facebookButtonAction(_ sender: UIButton) {
//        viewModel.loginWithFacebook(controller: self)
    }
    
    @IBAction func googleButtonAction(_ sender: UIButton) {
        viewModel.loginWithGoogle(vc: self) { success in
            if success {
                UIApplication.shared.windows.first?.rootViewController = ChatHubTabBar()
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                self.dismiss(animated: true)
            } else {
                print("false")
            }
        }
    }

    // MARK: - Functions
    private func configureStyle() {
        let buttons: [UIButton] = [facebookButton, googleButton, appleButton]
        for button in buttons {
            button.configureLoginButtonStyle()
        }
    }
    
    private func configureAppTitle() {
        appTitle.text   = ""
        let title       = "Stay connected with Chatify: fast, secure messaging for everyone."
        var charIndex   = 0.0
        for character in title {
            Timer.scheduledTimer(withTimeInterval: 0.08 * charIndex, repeats: false){ (timer) in
                self.appTitle.text?.append(character)
            }
            charIndex += 1
        }
    }
}
