//
//  UserProfile.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-07-20.
//

import Foundation

class UserProfile: DatabaseModel<User> { }

class User: NSObject, Decodable {
    var email: String = ""
    var fullName: String = ""
    var profileImageUrl: URL? = nil
    var userName: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case email
        case fullName
        case profileImageUrl
        case userName
    }
    
    // I do this custom init because I want to change from string to url
    required convenience init(from decoder: Decoder) throws {
        self.init()
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.email = try container.decode(String.self, forKey: .email)
            self.fullName = try container.decode(String.self, forKey: .fullName)
            self.userName = try container.decode(String.self, forKey: .userName)
            let imgUrl = try container.decode(String.self, forKey: .profileImageUrl)
            self.profileImageUrl = URL(string: imgUrl)
        } catch {
            print(error)
        }
    }
}
