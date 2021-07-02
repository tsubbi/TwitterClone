//
//  ImageAssetsName.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-28.
//

import UIKit

enum ImageAsset {
    enum ImageName: String {
        case home = "home_unselected"
        case explore = "search_unselected"
        case notifications = "like_unselected"
        case conversations = "email_unselected"
        // MARK: - ButtonImages
        case addTweet = "new_tweet"
        // MARK: - Title Image
        /// blue body
        case twitterLogo = "Twitter_Logo_Blue"
        /// white body
        case loginLogo = "TwitterLogo"
        // MARK: - Button Images
        /// register add image
        case addImage = "plus_photo"
        // MARK: - Login and Registeration
        case emailIcon = "ic_mail_outline"
        case passwordIcon = "ic_lock_outline"
        case userIcon = "ic_person_outline"
    }
    
    static func getImage(_ type: ImageName) -> UIImage? {
        return UIImage(named: type.rawValue)
    }
}
