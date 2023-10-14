//
//  UIColor+Extension.swift
//  AKKIN
//
//  Created by SJW on 2023/09/19.
//

import UIKit

extension UIColor {
    static var akkinGreen: UIColor {
        return UIColor(hex: "#23AD5F")
    }
    static var akkinBlack: UIColor {
        return UIColor(hex: "#19191B")
    }
    static var akkinWhite: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    // backgroundColor
    static var akkinGray0: UIColor {
        return UIColor(hex: "#FCFCFC")
    }
    // shadowColor
    static var akkinGray1: UIColor {
        return UIColor(hex: "#151515", alpha: 0.15)
    }
    // gray textColor
    static var akkinGray2: UIColor {
        return UIColor(hex: "#B0B0B0")
    }
    // borderColor
    static var akkinGray3: UIColor {
        return UIColor(hex: "#E5E5E5")
    }
    // date textColor
    static var akkinGray4: UIColor {
        return UIColor(hex: "#C5C5C5")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
