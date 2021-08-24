//
//  TweetData.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-08-14.
//

import Foundation

struct TweetData {
    let tweetID: String
    var tweetContent: Tweet
    
    init(id: String, tweetData: Any) {
        self.tweetID = id
        #warning("need to refactor!!!")
        // refactor sample is: https://stackoverflow.com/a/53565810/14939990
        // ===============================================================
        // transform sanpshot to object
        // https://stackoverflow.com/a/58510766/14939990
        let defaultTweet = Tweet(content: "", likes: 0, retweetCount: 0, timestamp: nil, uid: "")
        guard let data = try? JSONSerialization.data(withJSONObject: tweetData, options: []) else {
            self.tweetContent = defaultTweet
            return
        }
        self.tweetContent = JSONDecoder().decodeAndHandlesError(Tweet.self, from: data) ?? defaultTweet
    }
}

struct Tweet {
    var content: String
    var likes: Int
    var retweetCount: Int
    var timestamp: Date!
    let uid: String
    
    private enum CodingKeys: String, CodingKey {
        case content
        case likes = "like"
        case retweetCount = "retweet"
        case timestamp
        case uid
    }
}

extension Tweet: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.content = try container.decode(String.self, forKey: .content)
            self.likes = try container.decode(Int.self, forKey: .likes)
            self.retweetCount = try container.decode(Int.self, forKey: .retweetCount)
            let date = try container.decode(Double.self, forKey: .timestamp)
            self.timestamp = Date(timeIntervalSince1970: date)
            self.uid = try container.decode(String.self, forKey: .uid)
        } catch {
            self.content = ""
            self.likes = 0
            self.retweetCount = 0
            self.timestamp = nil
            self.uid = ""
        }
    }
}
