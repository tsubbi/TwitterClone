//
//  AuthSettings.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-29.
//

import UIKit

enum AuthSettingType {
    case login
    case register
    
    var mainActionButtonText: String {
        switch self {
        case .login:
            return "Log in"
        case .register:
            return "Sing up"
        }
    }
    
    var attributedButtonText: (String, String) {
        switch self {
        case .login:
            return ("Don't have an account?", " Sign up")
        case .register:
            return ("Already have an account?", " Log in")
        }
    }
    
    var spaceFromSide: CGFloat {
        return 32
    }
    
    var logoSize: CGFloat {
        switch self {
        case .login:
            return 150
        case .register:
            return 128
        }
    }
}
