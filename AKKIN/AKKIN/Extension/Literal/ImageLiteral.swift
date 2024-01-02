//
//  ImageLiteral.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

import UIKit

public enum AkkinImage {
    public static var akkinTitle: UIImage { .load(name: "AKKIN_Title") }
    
    public static var akkinIcon1: UIImage { .load(name: "icon_1")}
    public static var akkinIcon2: UIImage { .load(name: "icon_2")}
    public static var akkinIcon3: UIImage { .load(name: "icon_3") }
    public static var akkinIcon4: UIImage { .load(name: "icon_4") }
    public static var akkinIcon5: UIImage { .load(name: "icon_5") }
    public static var akkinIcon6: UIImage { .load(name: "icon_6") }
    
    public static var akkinImage1: UIImage { .load(name: "image_1")}
    public static var akkinImage2: UIImage { .load(name: "image_2")}
    public static var akkinImage3: UIImage { .load(name: "image_3")}
    public static var akkinImage4: UIImage { .load(name: "image_4")}
    public static var akkinImage5: UIImage { .load(name: "image_5")}
    
    public static var akkinlogin: UIImage { .load(name: "login")}
    public static var akkinOnboarding1: UIImage { .load(name: "onboarding1")}
    public static var akkinOnboarding2: UIImage { .load(name: "onboarding2")}
    public static var akkinOnboarding3: UIImage { .load(name: "onboarding3")}
    public static var akkinSplash: UIImage { .load(name: "splash")}
}

public enum AkkinButton {
    public static var addButton: UIImage { .load(name: "addButton") }
    public static var backButton: UIImage { .load(name: "backButton") }
    public static var checkButton: UIImage { .load(name: "checkButton") }
    public static var detailButton: UIImage { .load(name: "detailButton") }
    public static var editButton: UIImage { .load(name: "editButton") }
    public static var homeButton: UIImage { .load(name: "homeButton") }
    public static var myPageButton: UIImage { .load(name: "myPageButton") }
    public static var optionButton: UIImage { .load(name: "optionButton") }
    public static var previousButton: UIImage { .load(name: "previousButton") }
    public static var skipButton: UIImage { .load(name: "skipButton") }
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
}
