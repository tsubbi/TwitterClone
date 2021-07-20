//
//  Utilities.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-29.
//

import UIKit

class InputContainerView: UIView {
    
    enum InputfieldType {
        case email
        case password
        case fullName
        case userName
        
        var placeholderText: String {
            switch self {
            case .email:
                return "Email"
            case .password:
                return "Password"
            case .fullName:
                return "Full Name"
            case .userName:
                return "User Name"
            }
        }
        
        var displayImage: UIImage? {
            let route = ImageAsset.self
            switch self {
            case .email:
                return route.getImage(.emailIcon)
            case .fullName,
                 .userName:
                return route.getImage(.userIcon)
            case .password:
                return route.getImage(.passwordIcon)
            }
        }
    }
    
    private(set) var imageView: UIImageView
    private(set) var textField: UITextField
    private let dividerView: UIView
    
    init(frame: CGRect = .zero, of type: InputfieldType) {
        self.imageView = UIImageView(image: type.displayImage)
        self.textField = UITextField()
        self.dividerView = UIView()
        super.init(frame: frame)
        
        setupUI(of: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(of type: InputfieldType) {
        // image attributes
        self.imageView.contentMode = .scaleAspectFit
        
        // textfield attributes
        self.textField.textColor = .white
        // source: https://stackoverflow.com/a/27798073/14939990
        self.textField.attributedPlaceholder =
            NSAttributedString(string: type.placeholderText,
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.textField.isSecureTextEntry = type == .password ? true : false

        self.dividerView.backgroundColor = .white
        
        self.addSubview(self.imageView)
        self.addSubview(self.textField)
        self.addSubview(self.dividerView)
    }
    
    // MARK: - positioning
    override func layoutSubviews() {
        self.snp.makeConstraints { $0.height.equalTo(50) }
        self.imageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.equalTo(self).offset(8)
            $0.bottom.equalTo(self).offset(-8)
        }
        self.textField.snp.makeConstraints {
            $0.leading.equalTo(self.imageView.snp.trailing).offset(8)
            $0.trailing.equalTo(self.snp.trailing).offset(-8)
            $0.centerY.equalTo(self.imageView)
        }
        self.dividerView.snp.makeConstraints {
            $0.width.equalTo(self)
            $0.height.equalTo(0.75)
            $0.bottom.leading.trailing.equalTo(self)
        }
    }
}
