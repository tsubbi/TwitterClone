//
//  Colors.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-06-28.
//

import UIKit

// colors used in this project
struct ProjectColor {
    /// Main color of Twitter
    static let twitterBlue = UIColor.rgb(red: 29, green: 161, blue: 242)
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
