//
//  ImageAssetsName.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-28.
//

import Foundation

enum ImageAsset {
    enum TabBarImages: String {
        case home = "home_unselected"
        case explore = "search_unselected"
        case notifications = "like_unselected"
        case conversations = "email_unselected"
    }
    
    enum ButtonImages: String {
        case addTweet = "new_tweet"
    }
    
    enum TitleImage: String {
        case twitterLogo = "Twitter_Logo_Blue"
    }
}
