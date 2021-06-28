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
        btn.setImage(UIImage(named: ImageAsset.ButtonImages.addTweet.rawValue), for: .normal)
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return btn
    }()
    let tweetBtnWidth: CGFloat = 56
    let tweetBtnFromBottom: CGFloat = -64
    let tweetBtnFromRight: CGFloat = -16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewControllers()
        setupUI()
        layoutUI()
    }
    
    // MARK: - Helpers
    func configViewControllers() {
        let route = ImageAsset.TabBarImages.self
        // trasform vc into nav controller
        self.viewControllers = [(FeedController(), UIImage(named: route.home.rawValue)),
                                (ExploreViewController(), UIImage(named: route.explore.rawValue)),
                                (NotificationController(), UIImage(named: route.notifications.rawValue)),
                                (ConversationController(), UIImage(named: route.conversations.rawValue))]
            .map({
                let nav = UINavigationController(rootViewController: $0)
                nav.tabBarItem.image = $1
                nav.navigationBar.tintColor = .white
                return nav
            })
    }
    
    func setupUI() {
        self.view.addSubview(addTweetButton)
        self.addTweetButton.layer.cornerRadius = self.tweetBtnWidth.half()
    }
    
    func layoutUI() {
        self.addTweetButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.tweetBtnWidth)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(self.tweetBtnFromBottom)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(self.tweetBtnFromRight)
        }
    }
    
    // MARK: - Selector
    @objc func buttonAction() {
        print("Add tweet")
    }
}
