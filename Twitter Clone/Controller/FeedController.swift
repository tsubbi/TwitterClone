//
//  FeedController.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-28.
//

import UIKit
import SDWebImage

class FeedController: UICollectionViewController {
    // MARK: - Properties
    let profileImageView: UIImageView = {
        let profileImageSize: CGFloat = 32
        let iv = UIImageView()
        iv.backgroundColor = ProjectColor.twitterBlue
        iv.snp.makeConstraints { $0.height.width.equalTo(profileImageSize) }
        iv.layer.cornerRadius = profileImageSize/2
        iv.layer.masksToBounds = true
        return iv
    }()
    private let twitterLogoImageView: UIImageView = {
        let iv = UIImageView(image: ImageAsset.getImage(.twitterLogo))
        iv.contentMode = .scaleAspectFit
        iv.snp.makeConstraints { $0.width.height.equalTo(44) }
        return iv
    }()
    var userProfile: UserProfile? {
        didSet {
            // after user is being added, get profile images and display at navigation bar
            guard let user = self.userProfile?.user else { return }
            // fetch user profile image
            self.profileImageView.sd_setImage(with: user.profileImageUrl) { (image, error, type, url) in
                // when fetched, update ui
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.profileImageView)
            }
        }
    }
    var tweets: [TweetViewModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchTweet()
    }
    
    // MARK: - API
    func fetchTweet() {
        TweetService.shared.fetchTweets { (tweetViewModels) in
            self.tweets = tweetViewModels
        }
    }
    
    // MARK: - Helpers
    func setupUI() {
        self.collectionView.backgroundColor = .white
        let cellID = NSStringFromClass(TweetCollectionViewCell.self)
        self.collectionView.register(TweetCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        self.navigationItem.titleView = self.twitterLogoImageView
    }
}

// MARK: UICollection Data Source
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = NSStringFromClass(TweetCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TweetCollectionViewCell
        cell.updateCell(viewModel: tweets[indexPath.row])
        return cell
    }
}

// MARK: UICollection Delegate


// MARK: - UICollection View Flow Layout
#warning("chenge to new uicollectionvew api")
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 120)
    }
}
