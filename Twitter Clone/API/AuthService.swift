//
//  AuthService.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-07-05.
//

import Firebase

struct AuthService {
    static let shared = AuthService()
    var isUserLogged: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func logUserIn(withEmail email: String, and password: String, completion block: @escaping ((AuthDataResult?, Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password, completion: block)
    }
    
    func registerUser(of user: AuthCredentialModel, errorHandleView vc: UIViewController, completetion: @escaping(Error?, DatabaseReference) -> Void) {
        let fileName = NSUUID().uuidString
        
        // upload image first
        FirStorage.shared.updateNode(main: .profile_images, in: fileName, with: user.imageData) { (meta, error) in
            // and make sure we can get download images
            FirStorage.shared.getReference(of: .profile_images, with: fileName).downloadURL { (url, error) in
                guard let imgURL = url?.absoluteString else { return }
                // create the user profile
                Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
                    if let error = error {
                        self.handleError(error, in: vc)
                        return
                    }

                    guard let uid = result?.user.uid else { return }
                    let values = ["email": user.email, "userName": user.userName, "fullName": user.fullName, "profileImageUrl": imgURL]
                    // update the email, username, and full name to firebase database after it's successfully create an account
                    FirDatabase.shared.updateNode(main: .users, in: uid, with: values, completeion: completetion)
                }
            }
        }
    }
    
    func handleError(_ error: Error, in viewController: UIViewController) {
        Auth.auth().handleFireAuthError(error: error, in: viewController)
    }
    
    func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error for sign user out: \(error.localizedDescription)")
        }
    }
}

struct AuthCredentialModel {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let imageData: Data
}
