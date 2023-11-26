//
//  LoginViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/22.
//

import UIKit
import Moya
import AuthenticationServices

final class LoginViewController: BaseViewController {

    // MARK: UI Components
    private let loginView = LoginView()

    // MARK: Environment
    private let router = ExampleRouter()
    private let dummyProvider = MoyaProvider<DummyLoginAPI>(plugins: [MoyaLoggerPlugin]())
    private var appleLoginProvider = MoyaProvider<AppleLoginAPI>(plugins: [MoyaLoggerPlugin()])

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
            appleLogin()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Network
    private func appleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

//    private func getDummyAccount() {
//        dummyProvider.request(.getDummyAccount) { result in
//            switch result {
//            case .success(let response):
//                if let accessToken = response.response?.allHeaderFields["accessToken"] as? String {
//                            print("accessToken: \(accessToken)")
//                    UserDefaultHandler.accessToken = accessToken
//                } else {
//                    print("accessToken 헤더를 찾을 수 없습니다.")
//                }
//
//                if let refreshToken = response.response?.allHeaderFields["refreshToken"] as? String {
//                            print("refreshToken: \(refreshToken)")
//                    UserDefaultHandler.refreshToken = refreshToken
//                } else {
//                    print("refreshToken 헤더를 찾을 수 없습니다.")
//                }
//                self.router.presentMainViewController()
//            case .failure(let error):
//                print("API 호출 실패: \(error)")
//            }
//        }
//    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let appleToken = appleIDCredential.identityToken
            guard let appleTokenToString = String(data: appleToken!, encoding: .utf8) else {
                return
            }

            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            print("User appleToken : \(appleToken)")
            print("User appleTokenToString : \(appleTokenToString)")

            postAppleLogin(appleToken: appleTokenToString)
        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("apple login failed")
    }
    
    public func postAppleLogin(appleToken: String) {
        print("apple login try")
        NetworkService.shared.appleLogin.postAppleLogin(appleToken: appleToken) { result in
            switch result {
            case .success(let response):
                guard let data = response as? AppleLoginResponse else { return }
                UserDefaultHandler.accessToken = data.accessToken
                UserDefaultHandler.refreshToken = data.refreshToken
                print("success")
                //        self.router.presentMainViewController()
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }
}
