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
}

extension AppleLoginAPI: TargetType {
    var path: String {
        switch self {
        case .postAppleLogin:
            return URLConst.appleLogin
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postAppleLogin:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .postAppleLogin(let appleToken):
            return .requestParameters(parameters: [
                "appleToken": appleToken
            ], encoding: JSONEncoding.default)
        }
    }
    
//    var headers: [String : String]? {
//        return [
//            "Conten-Type": "application/json",
//            "token": UserDefaults.standard.string(forKey: "fcmToken") ?? ""
//        ]
//    }
}
