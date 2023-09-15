//
//  AppDependency.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import UIKit

import Then
import SnapKit

struct AppDependency {
    // MARK: Properties
    let windowCreator: (UIWindowScene) -> UIWindow
}

struct CompositionRoot {
    static func resolve() -> AppDependency {
        return AppDependency { scene in
            UIWindow(windowScene: scene).then {
                $0.rootViewController = UINavigationController(rootViewController: SplashViewController())
            }
        }
    }
}
