//
//  LoginViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/22.
//

import UIKit
import Moya

final class LoginViewController: BaseViewController {

    // MARK: UI Components
    private let loginView = LoginView()

    // MARK: Environment
    private let router = ExampleRouter()
    private let provider = MoyaProvider<DummyLoginAPI>(plugins: [MoyaLoggerPlugin]())

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        getDummyAccount()
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

    // MARK: Network
    private func getDummyAccount() {
        provider.request(.getDummyAccount) { result in
            switch result {
            case .success(let response):
                if let accessToken = response.response?.allHeaderFields["accessToken"] as? String {
                            print("accessToken: \(accessToken)")
                } else {
                    print("accessToken 헤더를 찾을 수 없습니다.")
                }

                if let refreshToken = response.response?.allHeaderFields["refreshToken"] as? String {
                            print("refreshToken: \(refreshToken)")
                } else {
                    print("refreshToken 헤더를 찾을 수 없습니다.")
                }
            case .failure(let error):
                print("API 호출 실패: \(error)")
            }
        }
    }
}
