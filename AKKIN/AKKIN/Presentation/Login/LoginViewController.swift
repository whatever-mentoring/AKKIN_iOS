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
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            let fullName = "\(appleIDCredential.fullName?.familyName ?? "")" + "\(appleIDCredential.fullName?.givenName ?? "user")"
            let email = appleIDCredential.email
            let appleToken = appleIDCredential.identityToken
            guard let appleTokenToString = String(data: appleToken!, encoding: .utf8) else {
                return
            }
            let authorizationCode = appleIDCredential.authorizationCode
            guard let authorizationCodeToString = String(data: authorizationCode!, encoding: .utf8) else {
                return
            }

            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \(fullName)")
            print("User appleTokenToString : \(appleTokenToString)")
            print("User authorizationCode : \(authorizationCodeToString)")

            UserDefaultHandler.appleToken = appleTokenToString
            UserDefaultHandler.authorizationCode = authorizationCodeToString
            UserDefaultHandler.userEmail = email ?? "${mail}"

            postAppleLogin(appleTokenToString)
        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("apple login failed")
    }
    
    public func postAppleLogin(_ appleToken: String) {
        print("apple login try")
        NetworkService.shared.appleLogin.postAppleLogin(appleToken: appleToken) { result in
            switch result {
            case .success(let response):
                guard let data = response as? AppleLoginResponse else { return }
                UserDefaultHandler.accessToken = data.accessToken
                UserDefaultHandler.refreshToken = data.refreshToken
                print("success")

                self.router.presentMainViewController()
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                sceneDelegate?.changeRootViewToMain()
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
