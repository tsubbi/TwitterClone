//
//  LoginViewController.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-28.
//

import UIKit

class LoginViewController: AuthBaseViewController {
    
    // MARK: - Properties
    private lazy var emailContainerView = InputContainerView(display: ImageAsset.getImage(.emailIcon), of: .email)
    private lazy var passwordContainerView = InputContainerView(display: ImageAsset.getImage(.passwordIcon), of: .password)
    
    init() {
        super.init(.login)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Selector
    @objc func handleLogin() {
        print("have some login process")
    }
    
    @objc func pushToRegister() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    // MARK: - Helpers
    func setupUI() {
        self.view.backgroundColor = ProjectColor.twitterBlue
        // this will turn the status bar from black to white, and it's embeded inside the nav bar.
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isHidden = true

        self.inputStackView.addArrangedSubview(self.emailContainerView)
        self.inputStackView.addArrangedSubview(self.passwordContainerView)
        self.inputStackView.addArrangedSubview(self.mainActionButton)
        self.mainActionButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        self.attributeButton.addTarget(self, action: #selector(pushToRegister), for: .touchUpInside)
    }
}
