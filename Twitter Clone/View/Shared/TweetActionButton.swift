//
//  TweetActionButton.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-08-14.
//

import UIKit

class TweetActionButton: UIButton {

    private let dimension: CGFloat = 20
    
    func createButton(of type: TweetButtonTypes) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(ImageAsset.getImage(type.image), for: .normal)
        button.tintColor = .darkGray
        button.snp.makeConstraints {
            $0.width.height.equalTo(dimension)
        }
        return button
    }
}

@objc enum TweetButtonTypes: Int {
    case share
    case like
    case retweet
    case comment
    
    var image: ImageAsset.ImageName {
        switch self {
        case .comment:
            return .comment
        case .share:
            return .share
        case .retweet:
            return .retweet
        case .like:
            return .like
        }
    }
}
