//
//  RegisterViewController.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-28.
//

import UIKit

class RegisterViewController: AuthBaseViewController {

    // MARK: - Properties
    private lazy var emailContainerView = InputContainerView(display: ImageAsset.getImage(.emailIcon), of: .email)
    private lazy var passwordContainerView = InputContainerView(display: ImageAsset.getImage(.passwordIcon), of: .password)
    private lazy var fullNameContainerView = InputContainerView(display: ImageAsset.getImage(.userIcon), of: .fullName)
    private lazy var userNameContainerView = InputContainerView(display: ImageAsset.getImage(.userIcon), of: .userName)
    private let imagePicker = UIImagePickerController()
    
    init() {
        super.init(.register)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Selector
    @objc func popToLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleRegister() {
        print("Registoring....")
    }
    
    @objc func addProfileImage() {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    func setupUI() {
        self.view.backgroundColor = ProjectColor.twitterBlue
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        
        self.inputStackView.addArrangedSubview(self.emailContainerView)
        self.inputStackView.addArrangedSubview(self.passwordContainerView)
        self.inputStackView.addArrangedSubview(self.fullNameContainerView)
        self.inputStackView.addArrangedSubview(self.userNameContainerView)
        self.inputStackView.addArrangedSubview(self.mainActionButton)
        
        if let headerBtn = self.headerButton {
            headerBtn.addTarget(self, action: #selector(addProfileImage), for: .touchUpInside)
        }
        self.mainActionButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        self.attributeButton.addTarget(self, action: #selector(popToLogin), for: .touchUpInside)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        // this will render the image properly
        self.headerButton?.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.headerButton?.layer.cornerRadius = AuthSettingType.register.logoSize/2
        self.headerButton?.layer.masksToBounds = true
        self.headerButton?.layer.borderColor = UIColor.white.cgColor
        self.headerButton?.layer.borderWidth = 3
        self.headerButton?.clipsToBounds = true
        self.headerButton?.imageView?.contentMode = .scaleAspectFill
        
        self.dismiss(animated: true, completion: nil)
    }
}
