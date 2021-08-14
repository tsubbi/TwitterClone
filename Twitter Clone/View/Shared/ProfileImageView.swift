//
//  ProfileImageView.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-08-14.
//

import UIKit

class ProfileImageView: UIImageView {
    init(dimension size: CGFloat = 48, contentMode: ContentMode = .scaleAspectFit, image: UIImage? = nil) {
        super.init(image: image)
        self.contentMode = contentMode
        self.clipsToBounds = true
        self.snp.makeConstraints {
            $0.width.height.equalTo(size)
        }
        self.layer.cornerRadius = size/2
        self.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
