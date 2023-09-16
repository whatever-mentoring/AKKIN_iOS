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

    func changeRootViewController() {
         guard let window = window else { return }
         window.rootViewController = UINavigationController(rootViewController: ExampleViewController())
         UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: nil)
     }
}
