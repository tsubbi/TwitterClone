//
//  TweetInputTextView.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-08-09.
//

import UIKit

class TweetInputTextView: UITextView {
    // MARK: - Properties
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "What to tweet"
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(textViewBeginEditing), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - selector
    @objc func textViewBeginEditing() {
        // placeholder label will appear when there is no input text, else the label will disappear when there are text inside the textview
        self.placeholderLabel.isHidden = !self.text.isEmpty
    }
    
    // MARK: - Helper
    func setupUI() {
        self.addSubview(self.placeholderLabel)
        self.backgroundColor = .white
        self.font = UIFont.systemFont(ofSize: 16)
        self.isScrollEnabled = false
        self.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        layoutUI()
    }
    func layoutUI() {
        self.placeholderLabel.snp.makeConstraints {
            let standardPadding: CGFloat = 4
            $0.top.equalTo(self).offset(standardPadding*2)
            $0.left.equalTo(self).offset(standardPadding)
        }
    }
}
