//
//  LoginView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/22.
//

import UIKit
import AuthenticationServices

final class LoginView: BaseView {

    // MARK: UI Components
    private let loginImageView = UIImageView().then {
        $0.image = AkkinImage.akkinlogin
    }

    private let appleLoginButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)

    // MARK: Properties
    var tapLogin: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(loginImageView)
        addSubview(appleLoginButton)

        appleLoginButton.addTarget(self, action: #selector(handleLoginEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        loginImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        appleLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(56)
        }
    }

    // MARK: Event
    @objc private func handleLoginEvent() {
        tapLogin?()
    }
}
