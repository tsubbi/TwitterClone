//
//  ExploreViewController.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-28.
//

import UIKit

class ExploreViewController: UIViewController {

    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Helpers
    func setupUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Explore"
    }
}
