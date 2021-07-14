//
//  FirAuthErrorExtension.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-07-03.
//

import Foundation
import Firebase

// https://gist.github.com/nelglez/7901c12f550cd241e8cf8a55381ae842
extension Auth {
    /// This will hand the error from Firebase Auth
    func handleFireAuthError(error: Error, in viewController: UIViewController) {
        if let error = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "Error", message: error.errorMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
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
