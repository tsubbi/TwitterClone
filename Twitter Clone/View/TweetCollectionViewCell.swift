//
//  TweetCollectionViewCell.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-08-14.
//

import UIKit

class TweetCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    private let profileImageView = ProfileImageView()
    private let tweetContent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    private let infoLabel = UILabel()
    private let commentButton: UIButton = {
        let button = TweetActionButton().createButton(of: .comment)
        return button
    }()
    private var contentStack = UIStackView()
    private var tweetButtonStack = UIStackView()
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func setupUI() {
        self.backgroundColor = .white
        self.addSubview(self.profileImageView)
        
        self.contentStack = UIStackView(arrangedSubviews: [self.infoLabel, self.tweetContent])
        self.contentStack.axis = .vertical
        self.contentStack.distribution = .fillProportionally
        self.contentStack.spacing = 4
        self.infoLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(self.contentStack)
        
        let commentBtn = TweetActionButton().createButton(of: .comment)
        commentBtn.addTarget(self, action: #selector(comment), for: .touchUpInside)
        let likeBtn = TweetActionButton().createButton(of: .like)
        likeBtn.addTarget(self, action: #selector(like), for: .touchUpInside)
        let shareBtn = TweetActionButton().createButton(of: .share)
        shareBtn.addTarget(self, action: #selector(share), for: .touchUpInside)
        let retweetBtn = TweetActionButton().createButton(of: .retweet)
        retweetBtn.addTarget(self, action: #selector(retweet), for: .touchUpInside)
        self.tweetButtonStack = UIStackView(arrangedSubviews: [commentBtn, retweetBtn, likeBtn, shareBtn])
        self.tweetButtonStack.axis = .horizontal
        self.tweetButtonStack.spacing = 72
        self.addSubview(self.tweetButtonStack)
        
        let underlineView = UIView()
        self.addSubview(underlineView)
        underlineView.backgroundColor = .systemGroupedBackground
        
        layoutUI()
    }
    
    private func layoutUI () {
        self.profileImageView.snp.makeConstraints {
            $0.top.equalTo(self).offset(8)
            $0.left.equalTo(self).offset(8)
        }
        
        self.contentStack.snp.makeConstraints {
            $0.top.equalTo(self).offset(12)
            $0.left.equalTo(self.profileImageView.snp.right).offset(12)
        }
        
        self.tweetButtonStack.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.bottom.equalTo(self).offset(-8)
        }
        
        self.subviews.last?.snp.makeConstraints({
            $0.left.bottom.right.equalTo(self)
            $0.height.equalTo(1)
        })
    }
    
    func updateCell(viewModel: TweetViewModel) {
        self.infoLabel.attributedText = viewModel.userInfo
        self.tweetContent.text = viewModel.tweetContent
        self.profileImageView.sd_setImage(with: viewModel.profileImageURL, completed: nil)
    }
}

// MARK: - Button Selector
// tweet button actions
extension TweetCollectionViewCell {
    @objc func like() {
        print(#function)
    }
    
    @objc func share() {
        print(#function)
    }
    
    @objc func retweet() {
        print(#function)
    }
    
    @objc func comment() {
        print(#function)
    }
}
