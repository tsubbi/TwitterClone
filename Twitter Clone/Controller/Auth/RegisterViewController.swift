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
    private var profileImage: UIImage?
    
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
        #warning("""
            Validation Check on Textfield:
            1. make sure the textfield is NOT empty
            2. make sure the string is correspond to correct type
        """)
        // need to compress the data or bandwidth and storage will be used quickly
        guard let profileImageData = self.profileImage?.jpegData(compressionQuality: 0.3) else { return }
        #if DEBUG
        let email = "leader@platelet.body.com"
        let password = "platelet"
        let fullName = "Little Leader"
        let userName = "Platelet Leader"
        #else
        guard let email = self.emailContainerView.textField.text else { return }
        guard let password = self.passwordContainerView.textField.text else { return }
        guard let fullName = self.fullNameContainerView.textField.text else { return }
        guard let userName = self.userNameContainerView.textField.text else { return }
        #endif
        
        let user = AuthCredentialModel(email: email,
                                       password: password,
                                       fullName: fullName,
                                       userName: userName,
                                       imageData: profileImageData)
        AuthService.shared.registerUser(of: user, errorHandleView: self) { (error, reference) -> Void in
            // update users
            guard let tabVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController as? TwitterTabBarViewController else { return }
            tabVC.configViewControllerWhenLoggedIn()
            
            self.dismiss(animated: true, completion: nil)
        }
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
        self.profileImage = profileImage
        
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
