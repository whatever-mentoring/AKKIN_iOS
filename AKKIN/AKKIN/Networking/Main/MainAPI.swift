//
//  MainAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

import Moya
import Foundation

enum MainAPI {
    case getMain
}

extension MainAPI: TargetType {
    var path: String {
        switch self {
        case .getMain:
            return URLConst.main
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMain:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getMain:
            return .requestPlain
        }
    }
}
