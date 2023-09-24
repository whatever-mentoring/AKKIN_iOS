//
//  LoginView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/22.
//

import UIKit

final class LoginView: BaseView {

    // MARK: UI Components
    private let loginImageView = UIImageView().then {
        $0.image = UIImage(named: "login")
    }

    private let loginButton = BaseButton().then {
        $0.backgroundColor = .black
        $0.setImage(UIImage(named: "apple_logo"), for: .normal)
        $0.setTitle("Apple로 로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.layer.cornerRadius = 8
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 17)
    }

    // MARK: Properties
    var tapAdd: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(loginImageView)
        addSubview(loginButton)

        loginButton.addTarget(self, action: #selector(handleAddEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        loginImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(56)
        }
    }

    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}
