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
    let tweetBtnSize: CGFloat = 56
    let tweetBtnFromBottom: CGFloat = -64
    let tweetBtnFromRight: CGFloat = -16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !AuthService.shared.isUserLogged {
            configViewControllerWhenNeedAuth()
        } else {
            configViewControllerWhenLoggedIn()
        }
    }
    
    func configViewControllerWhenNeedAuth () {
        DispatchQueue.main.async {
            self.view.backgroundColor = ProjectColor.twitterBlue
            let nav = UINavigationController(rootViewController: LoginViewController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    func configViewControllerWhenLoggedIn() {
        let route = ImageAsset.self
        // trasform vc into nav controller
        self.viewControllers = [(FeedController(), route.getImage(.home)),
                                (ExploreViewController(), route.getImage(.explore)),
                                (NotificationController(), route.getImage(.notifications)),
                                (ConversationController(), route.getImage(.conversations))]
            .map({
                let nav = UINavigationController(rootViewController: $0)
                nav.tabBarItem.image = $1
                nav.navigationBar.tintColor = .white
                return nav
            })
        
        setupUI()
        layoutUI()
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
