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
    func fetchUser(completion: @escaping (UserProfile) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        FirDatabase.shared.getReference(of: .users, with: userUID).observeSingleEvent(of: .value) { (snapShot) in
            let userProfile = UserProfile(uid: userUID, user: snapShot.value as Any)
            completion(userProfile)
        }
    }
}

