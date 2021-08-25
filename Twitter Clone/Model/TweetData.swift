//
//  TweetData.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-08-14.
//

import Foundation

class TweetData: DatabaseModel<Tweet> { }

class Tweet: NSObject, Decodable {
    var content: String = ""
    var likes: Int = 0
    var retweetCount: Int = 0
    var timestamp: Date? = nil
    var uid: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case content
        case likes = "like"
        case retweetCount = "retweet"
        case timestamp
        case uid
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.content = try container.decode(String.self, forKey: .content)
            self.likes = try container.decode(Int.self, forKey: .likes)
            self.retweetCount = try container.decode(Int.self, forKey: .retweetCount)
            let date = try container.decode(Double.self, forKey: .timestamp)
            self.timestamp = Date(timeIntervalSince1970: date)
            self.uid = try container.decode(String.self, forKey: .uid)
        } catch {
            print(error)
        }
    }
}
