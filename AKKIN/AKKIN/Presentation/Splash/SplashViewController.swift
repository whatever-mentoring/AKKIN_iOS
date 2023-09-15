//
//  SplashViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/15.
//

import UIKit

final class SplashViewController: BaseViewController {

    private let splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.8) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.changeRootViewController()
        }
    }

    func setHierarchy() {
        view.addSubview(splashImageView)
    }

    func setConstraints() {
        splashImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
