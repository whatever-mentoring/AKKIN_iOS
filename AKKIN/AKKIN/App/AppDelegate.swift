//
//  AppDelegate.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import UIKit
import KakaoSDKCommon


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KakaoSDK.initSDK(appKey: "1a21d7c73dbf14515468d75c515372b1")
        return true
    }
}


