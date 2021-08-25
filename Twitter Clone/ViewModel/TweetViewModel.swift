//
//  TweetViewModel.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-08-23.
//

import UIKit

struct TweetViewModel {
    let tweetData: TweetData
    let userProfile: UserProfile
    var profileImageURL: URL? {
        return userProfile.modelData.profileImageUrl
    }
    var userInfo: NSAttributedString {
        let title = NSMutableAttributedString(string: userProfile.modelData.fullName,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(userProfile.modelData.userName)",
                                        attributes: [.foregroundColor: UIColor.lightGray,
                                                     .font: UIFont.systemFont(ofSize: 14)]))
        if let dateStr = self.timestamp {
            title.append(NSAttributedString(string: " ᐧ \(dateStr)",
                                            attributes: [.foregroundColor: UIColor.lightGray,
                                                         .font: UIFont.systemFont(ofSize: 14)]))
        }
        
        return title
    }
    
    var tweetContent: String? {
        return tweetData.modelData.content
    }
    
    private var timestamp: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        // if unable to obtain the timestamp from database, return nil
        guard let dataTime = tweetData.modelData.timestamp else { return nil }
        return formatter.string(from: dataTime, to: now)
    }
    
    init(tweet data: TweetData, user profile: UserProfile) {
        self.tweetData = data
        self.userProfile = profile
    }
}
