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
    
    /// User login process
    /// - Parameters:
    ///   - email: The email of user
    ///   - password: the password of user
    ///   - block: actions after the process is completed
    func logUserIn(withEmail email: String, and password: String, completion block: @escaping ((AuthDataResult?, Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password, completion: block)
    }
    
    /// User register process
    /// - Parameters:
    ///   - user: User model that contains user's info
    ///   - vc: the targeting view will display message if error happens
    ///   - completetion: actions after the process is completed
    func registerUser(of user: AuthCredentialModel, errorHandleView vc: UIViewController, completetion: @escaping (Result<DatabaseReference, Error>) -> Void) {
        let fileName = NSUUID().uuidString
        
        // upload image first
        FirStorage.shared.updateNode(main: .profileImages, in: fileName, with: user.imageData) { _ in
            // and make sure we can get download images
            FirStorage.shared.getReference(of: .profileImages, with: fileName).downloadURL { (url, error) in
                guard let imgURL = url?.absoluteString else { return }
                // create the user profile
                Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
                    if let error = error {
                        completetion(.failure(error))
                        return
                    }

                    guard let uid = result?.user.uid else { return }
                    // the updated values need to be in dictionary form
                    let values = ["email": user.email, "userName": user.userName, "fullName": user.fullName, "profileImageUrl": imgURL]
                    // update the email, username, and full name to firebase database after it's successfully create an account
                    FirDatabase.shared.updateNode(main: .users, in: uid, with: values, completeion: completetion)
                }
            }
        }
    }
    
    // this is used as api because I want to keep this simple to decouple the firebase and vc
    // https://gist.github.com/nelglez/7901c12f550cd241e8cf8a55381ae842
    /// Display message when error happens
    /// - Parameters:
    ///   - error: firebase error
    ///   - viewController: targeting VC
    func handleError(_ error: Error, in viewController: UIViewController) {
        if let error = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "Error", message: error.errorMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    /// to sign out user
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

/// This is the error code from firebase auth
extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account. Pick another email!"
        case .userNotFound:
            return "Account not found for the specific user. Please check and try again."
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email."
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password or email is incorrect."
        default:
            return "Sorry, something went wrong."
        }
    }
}
