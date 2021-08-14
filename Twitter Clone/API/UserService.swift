//
//  UserService.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-07-12.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    /// To get user info
    /// - Parameter completion: actions after the process is completed
    func fetchUser(uid: String, completion: @escaping (UserProfile) -> Void) {
        FirDatabase.shared.getReference(of: .users, with: uid).observeSingleEvent(of: .value) { (snapShot) in
            let userProfile = UserProfile(uid: uid, user: snapShot.value as Any)
            completion(userProfile)
        }
    }
}

