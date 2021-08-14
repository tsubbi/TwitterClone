//
//  UserProfile.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-07-20.
//

import Foundation

struct UserProfile {
    var user: User? = nil
    let uid: String
    
    init(uid: String, user: Any) {
        self.uid = uid
        #warning("need to refactor!!!")
        // refactor sample is: https://stackoverflow.com/a/53565810/14939990
        // ===============================================================
        // transform sanpshot to object
        // https://stackoverflow.com/a/58510766/14939990
        guard let data = try? JSONSerialization.data(withJSONObject: user, options: []) else { return }
        self.user = JSONDecoder().decodeAndHandlesError(User.self, from: data)
    }
}

struct User {
    var email: String
    var fullName: String
    let profileImageUrl: URL?
    var userName: String
    
    private enum CodingKeys: String, CodingKey {
        case email
        case fullName
        case profileImageUrl
        case userName
    }
}

extension User: Decodable {
    // I do this custom init because I want to change from string to url
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.email = try container.decode(String.self, forKey: .email)
            self.fullName = try container.decode(String.self, forKey: .fullName)
            self.userName = try container.decode(String.self, forKey: .userName)
            let imgUrl = try container.decode(String.self, forKey: .profileImageUrl)
            self.profileImageUrl = URL(string: imgUrl)
        } catch {
            self.email = ""
            self.fullName = ""
            self.userName = ""
            self.profileImageUrl = nil
        }
    }
}
