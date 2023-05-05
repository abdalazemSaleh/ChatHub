//
//  LoginViewModel.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-04-30.
//

import Foundation
import Firebase
import GoogleSignIn
import FacebookLogin

class LoginModelView {
    
    // MARK: - Variables
    let database = DatabaseManger.shared
    let storage = StorageManager.shared
    
    // MARK: - Login with google
    func loginWithGoogle(vc: UIViewController, completion: @escaping (Bool) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [weak self] result, error in
            guard let self = self else { return }
            guard error == nil else { return }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            self.sendDataToFirebase(credential: credential) { success in
                guard success else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
    
    private func sendDataToFirebase(credential: AuthCredential, completoin: @escaping (Bool) -> Void) {
        Auth.auth().signIn(with: credential) { [weak self] result, error in
            guard let self = self else { return }
            guard error == nil else { return }
            
            guard let user = result?.user,
                    let userName = user.displayName,
                    let userEmail = user.email,
                    let userImage = user.photoURL else { return }
            
            let userModel: UserModel = UserModel(name: userName, emailAddress: userEmail)
            let fileName = userModel.profilePictureFileName
            self.getImageData(url: userImage, fileName: fileName)
            
            self.creatUser(user: userModel) { success in
                guard success else {
                    completoin(false)
                    return
                }
                completoin(true)
                UserData.chacheUserModel(user: userModel)
            }
        }
    }
    
    private func getImageData(url: URL, fileName: String)  {
        let imageDownloader = ImageDownloader(url: url)
        imageDownloader.downloadImageFromUrlAndReturnData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.uploadPhotoToStorage(data: data, fileName: fileName)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func uploadPhotoToStorage(data: Data, fileName: String) {
        StorageManager.shared.uploadUserPhoto(data: data, fileName: fileName) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }

    private func creatUser(user: UserModel, completoin: @escaping (Bool) -> Void) {
        database.creatNewUser(userModel: user) { success in
            guard success else {
                completoin(false)
                return
            }
            completoin(true)
        }
    }
    
    // MARK: - Login with facebook
//    func loginWithFacebook(controller: UIViewController) {
//        let loginManger = LoginManager()
//        loginManger.logIn(permissions: ["public_profile", "email"], from: controller) { [weak self] result, error in
//            guard let self = self else { return }
//            guard let idTokenString = AuthenticationToken.current?.tokenString else { return }
//            self.request(token: idTokenString)
//        }
//    }
    
//    private func request(token: String) {
//        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
//                                                         parameters: ["fields": "email, first_name, last_name, picture.type(large)"],
//                                                         tokenString: token,
//                                                         version: nil,
//                                                         httpMethod: .get)
//        facebookRequest.start { _, result, error in
//            guard let result = result as? [String: Any],
//                  error == nil else {
//                print(error?.localizedDescription)
//                      return
//                  }
//
//            guard let name = result["name"] as? String else {
//                print("Problem in name")
//                return
//            }
//            print(name)
//        }
//    }
    
    //            let credential = FacebookAuthProvider.credential(withAccessToken: idTokenString)
    //            Auth.auth().signIn(with: credential) { authResult, error in
    ////                guard let result = authResult, error == nil else {
    ////                    return
    ////                }
    //            }

}
