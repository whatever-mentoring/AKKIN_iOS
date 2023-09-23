//
//  LoginViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/22.
//

import UIKit

final class LoginViewController: BaseViewController {

    // MARK: UI Components
    private let loginView = LoginView()

    // MARK: Environment
    private let router = ExampleRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        view.addSubview(loginView)

        loginView.tapAdd = { [weak self] in
            guard let self else { return }
            router.presentMainViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
