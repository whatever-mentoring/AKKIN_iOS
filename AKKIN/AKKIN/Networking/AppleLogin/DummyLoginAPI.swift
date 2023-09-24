//
//  DummyLoginAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

import Moya
import Foundation

enum DummyLoginAPI {
    case getDummyAccount
}

extension DummyLoginAPI: TargetType {
    var path: String {
        switch self {
        case .getDummyAccount:
            return "/login/dummy/101"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDummyAccount:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getDummyAccount:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getDummyAccount:
            return nil
        }
    }
}
