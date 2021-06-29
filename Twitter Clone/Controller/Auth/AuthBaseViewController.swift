//
//  AuthBaseViewController.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-29.
//

import UIKit

class AuthBaseViewController: UIViewController {
    // MARK: - Properties
    private let setting: AuthSettingType
    var headerImageView: UIImageView?
    var headerButton: UIButton?
    var inputStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    /// white bg button. For submitting input values.
    /// This button will be inside the stack view
    var mainActionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(ProjectColor.twitterBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        return btn
    }()
    /// white text button for switch views between login and register
    var attributeButton: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()
    
    // MARK: - Init
    init(_ setting: AuthSettingType) {
        self.setting = setting
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        layoutUI()
    }
    
    private func setUI() {
        if setting == .login {
            self.headerImageView = UIImageView(image: ImageAsset.getImage(.loginLogo))
            self.headerImageView?.contentMode = .scaleAspectFit
            self.headerImageView?.clipsToBounds = true
        } else {
            self.headerButton = UIButton(type: .system)
            self.headerButton?.setImage(ImageAsset.getImage(.addImage), for: .normal)
            self.headerButton?.tintColor = .white
        }
        
        // add title on the main action button
        self.mainActionButton.setTitle(setting.mainActionButtonText, for: .normal)
        // add title on the attribute button
        let attributeTitle = NSMutableAttributedString(string: setting.attributedButtonText.0,
                                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                                    NSAttributedString.Key.foregroundColor: UIColor.white])
        attributeTitle.append(NSMutableAttributedString(string: setting.attributedButtonText.1,
                                                        attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                                                                     NSMutableAttributedString.Key.foregroundColor: UIColor.white]))
        self.attributeButton.setAttributedTitle(attributeTitle, for: .normal)
        // add views
        if let headerImg = self.headerImageView {
            self.view.addSubview(headerImg)
        } else if let headerBtn = self.headerButton {
            self.view.addSubview(headerBtn)
        }
        self.view.addSubview(self.inputStackView)
        self.view.addSubview(self.attributeButton)
        // add tap reconnizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
    }
    
    private func layoutUI() {
        let headerView = self.view.subviews.first!
        let safeArea = self.view.safeAreaLayoutGuide
        headerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeArea)
            $0.width.height.equalTo(setting.logoSize)
        }
        self.inputStackView.snp.makeConstraints {
            if headerView is UIButton {
                $0.top.equalTo(headerView.snp.bottom).offset(setting.spaceFromSide)
            } else {
                $0.top.equalTo(headerView.snp.bottom)
            }
            $0.trailing.equalToSuperview().offset(-setting.spaceFromSide)
            $0.leading.equalToSuperview().offset(setting.spaceFromSide)
        }
        self.attributeButton.snp.makeConstraints {
            $0.bottom.equalTo(safeArea)
            $0.leading.equalToSuperview().offset(setting.spaceFromSide)
            $0.trailing.equalToSuperview().offset(-setting.spaceFromSide)
        }
    }
    
    // MARK: - Selector
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
}
