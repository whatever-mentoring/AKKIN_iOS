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
    
    private enum ResponseData {
        case postAppleLogin
    }

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
            //getDummyAccount()
            handleAuthorizationAppleIDButtonPress()
            
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    // MARK: Network
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
    
    // 로그인 진행하는 화면 표출
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            if let email = appleIDCredential.email {
                print("이메일 : \(email)")
            }
            // 두번째부터는 credential.email은 nil이고, credential.identityToken에 들어있다.
            else {
                // credential.identityToken은 jwt로 되어있고, 해당 토큰을 decode 후 email에 접근해야한다.
                if let tokenString = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8) {
                    let email2 = Utils.decode(jwtToken: tokenString)["email"] as? String ?? ""
                    print("이메일 - \(email2)")
                }
            }
            let identityToken = appleIDCredential.identityToken
            let authorizationToken = appleIDCredential.authorizationCode
            let tokenString2 = String(data: authorizationToken!, encoding: .utf8) ?? ""
            let tokenString = String(data: identityToken!, encoding: .utf8) ?? ""
            
            print("User ID : \(userIdentifier)")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            print("User authToken : \(tokenString2)")
            print("User Token : \((identityToken?.base64EncodedString())!)")
        
            postAppleLogin(appleToken: tokenString)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
                self.router.presentMainViewController()
            }
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
    public func postAppleLogin(appleToken: String) {
            NetworkService.shared.appleLogin.postAppleLogin(appleToken: appleToken) { result in
                switch result {
                case .success(let response):
                    guard let data = response as? AppleLoginResponse else { return }
                    UserDefaultHandler.accessToken = data.accessToken
                    UserDefaultHandler.refreshToken = data.refreshToken
                    print("success")
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
