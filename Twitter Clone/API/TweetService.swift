//
//  TweetService.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-08-13.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func postTweet(content: String, completion block: @escaping (Result<DatabaseReference, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let timeStamp = Int(Date().timeIntervalSince1970)
        let values: [String: Any] = ["uid": uid,
                                     "timestamp": timeStamp,
                                     "like": 0,
                                     "retweet": 0,
                                     "content": content]
        FirDatabase.shared.postTweet(main: .tweets, with: values, completion: block)
    }
    
    func fetchTweets(completion block:@escaping ([TweetViewModel]) -> Void) {
        var tweets: [TweetViewModel] = []
        // fetch the avalible tweets that is database
        FirDatabase.shared.fetchTweet(of: .tweets) { (snapshots) in
            // key is the tweet id
            let tweetID = snapshots.key
            // convert snapshot to tweet model
            let tweetData = TweetData(id: tweetID, snapshotData: snapshots.value as Any)
            // get the user who wrote the tweet and return as the view model for display
            UserService.shared.fetchUser(uid: tweetData.modelData.uid) { (profile) in
                let tweetViewModel = TweetViewModel(tweet: tweetData, user: profile)
                tweets.append(tweetViewModel)
                block(tweets)
            }
        }
    }
}

