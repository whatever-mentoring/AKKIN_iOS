//
//  AppleLoginAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

import Moya
import Foundation

enum AppleLoginAPI {
    case postAppleLogin(appleToken: String)
    case postAppleRevoke(appleToken: String, authorizationCode: String)
    case getAppleLogout
}

extension AppleLoginAPI: TargetType {
    var path: String {
        switch self {
        case .postAppleLogin:
            return URLConst.appleLogin
        case .postAppleRevoke:
            return URLConst.appleRevoke
        case .getAppleLogout:
            return URLConst.appleLogout
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postAppleLogin:
            return .post
        case .postAppleRevoke:
            return .post
        case .getAppleLogout:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .postAppleLogin(let appleToken):
            return .requestParameters(parameters: [
                "appleToken": appleToken
            ], encoding: JSONEncoding.default)
        case .postAppleRevoke(let appleToken, let authorizationCode):
            return .requestParameters(parameters: [
                "appleToken": appleToken,
                "authorizationCode": authorizationCode
            ], encoding: JSONEncoding.default)
        case .getAppleLogout:
            return .requestPlain
        }
    }
}
