//
//  UploadTweetViewController.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-08-09.
//

import UIKit

class UploadTweetViewController: UIViewController {

    // MARK: - Properties
    let profile: UserProfile
    let standardSizePadding: CGFloat = 16
    // this button need lazy decleration because when the vc is initilized, the selector may not be ready to use. Therefore, to solve this issue, need the lazy so the selector can be ready when being called later.
    private lazy var tweetButton: UIButton = {
        let btn = UIButton()
        let buttonSize = CGSize(width: 64, height: 32)
        btn.backgroundColor = ProjectColor.twitterBlue
        btn.setTitle("Tweet", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.frame = CGRect(origin: .zero, size: buttonSize)
        btn.layer.cornerRadius = buttonSize.height/2
        btn.addTarget(self, action: #selector(uploadTweet), for: .touchUpInside)
        
        return btn
    }()
    
    private let profileImageView = ProfileImageView()
    let inputTextView = TweetInputTextView()

    // MARK: - Life Cycle
    init(profile: UserProfile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Selectors
    @objc func cancelTweet() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // post tweet
    @objc func uploadTweet() {
        guard let tweetContent = self.inputTextView.text else { return }
        
        TweetService.shared.postTweet(content: tweetContent) { (result) in
            switch result {
            case .success(_):
                self.dismiss(animated: true, completion: nil)
            case .failure(let err):
                AuthService.shared.handleError(err, in: self)
            }
        }
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    func setupUI() {
        self.view.backgroundColor = .white
        configNavigationBar()
        let stackView = UIStackView(arrangedSubviews: [self.profileImageView, self.inputTextView])
        stackView.axis = .horizontal
        stackView.spacing = 12
        self.view.addSubview(stackView)
        // the image has been cashed by sdwebimage lib
        self.profileImageView.sd_setImage(with: self.profile.user?.profileImageUrl, completed: nil)
        layoutUI()
    }
    
    private func configNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTweet))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.tweetButton)
    }
    
    private func layoutUI() {
        for view in self.view.subviews {
            if view is UIStackView {
                view.snp.makeConstraints {
                    $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(standardSizePadding)
                    $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(standardSizePadding)
                    $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(standardSizePadding)
                }
            }
        }
    }
}
