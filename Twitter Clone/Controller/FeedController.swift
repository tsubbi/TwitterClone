//
//  FeedController.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-28.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    // MARK: - Helpers
    func setupUI() {
        self.view.backgroundColor = .white
        self.navigationItem.titleView = self.twitterLogoImageView
    }
}
