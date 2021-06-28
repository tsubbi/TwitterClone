//
//  FeedController.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-28.
//

import UIKit

class FeedController: UIViewController {
    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    // MARK: - Helpers
    func setupUI() {
        self.view.backgroundColor = .white
        let iv = UIImageView(image: UIImage(named: ImageAsset.TitleImage.twitterLogo.rawValue))
        iv.contentMode = .scaleAspectFit
        self.navigationItem.titleView = iv
    }
}
