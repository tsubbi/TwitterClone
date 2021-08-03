//
//  TwitterTabBarViewController.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-28.
//

import UIKit
import SnapKit

class TwitterTabBarViewController: UITabBarController {
    // MARK: - Properties
    // add btn inside tabbar controller to show up in every sub vc
    let addTweetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.backgroundColor = ProjectColor.twitterBlue
        btn.setImage(ImageAsset.getImage(.addTweet), for: .normal)
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return btn
    }()
    private let tweetBtnSize: CGFloat = 56
    private let tweetBtnFromBottom: CGFloat = -64
    private let tweetBtnFromRight: CGFloat = -16
    private let feed = FeedController()
    private let explore = ExploreViewController()
    private let notification = NotificationController()
    private let chat = ConversationController()
    var userProfile: UserProfile? {
        didSet {
            // assign the fatched profile to feed controller
            self.feed.userProfile = self.userProfile
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !AuthService.shared.isUserLogged {
            // if user is not logged in handles login first
            configViewControllerWhenNeedAuth()
        } else {
            configViewControllerWhenLoggedIn()
        }
    }
    
    func fetchUser() {
        UserService.shared.fetchUser {
            self.userProfile = $0
        }
    }
    
    func configViewControllerWhenNeedAuth () {
        // it seemed firebase is not work in main thread so need to head back to main thread to present the view
        DispatchQueue.main.async {
            self.view.backgroundColor = ProjectColor.twitterBlue
            let nav = UINavigationController(rootViewController: LoginViewController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    // shows the views of each section
    func configViewControllerWhenLoggedIn() {
        let route = ImageAsset.self
        // trasform vc into nav controller
        self.viewControllers = [(self.feed, route.getImage(.home)),
                                (self.explore, route.getImage(.explore)),
                                (self.notification, route.getImage(.notifications)),
                                (self.chat, route.getImage(.conversations))]
            .map({
                let nav = UINavigationController(rootViewController: $0)
                nav.tabBarItem.image = $1
                nav.navigationBar.tintColor = .white
                return nav
            })
        
        setupUI()
        layoutUI()
        fetchUser()
    }
    
    private func setupUI() {
        self.view.addSubview(addTweetButton)
        self.addTweetButton.layer.cornerRadius = self.tweetBtnSize.half()
    }
    
    private func layoutUI() {
        self.addTweetButton.snp.makeConstraints {
            $0.width.height.equalTo(self.tweetBtnSize)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(self.tweetBtnFromBottom)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(self.tweetBtnFromRight)
        }
    }
    
    // MARK: - Selector
    @objc func buttonAction() {
        print("Add tweet")
    }
}
