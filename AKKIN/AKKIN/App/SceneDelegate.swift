//
//  SceneDelegate.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: Properties
    var window: UIWindow?
    let dependency: AppDependency
    
    // MARK: Initializer
    override init() {
        self.dependency = CompositionRoot.resolve()
        super.init()
    }
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = dependency.windowCreator(windowScene)
        window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        // kakao123456789://kakaolink
        // kakao123456789://kakaolink?key1=value1&key2=value2
        if let url = URLContexts.first?.url {
            print("url : \(url)")
        }
    }

    func changeRootViewController() {
        guard let window = window else { return }
        if Storage.isFirstTime() {
            window.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
        } else {
            window.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
        UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: nil)
     }

    func changeRootViewToMain() {
         guard let window = window else { return }
         window.rootViewController = UINavigationController(rootViewController: MainViewController())
         UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: nil)
     }
}
