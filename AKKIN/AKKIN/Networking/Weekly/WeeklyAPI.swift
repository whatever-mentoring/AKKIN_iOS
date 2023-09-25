//
//  WeeklyAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

import Moya
import Foundation

enum WeeklyAPI {
    case getWeekly
}

extension WeeklyAPI: TargetType {
    var path: String {
        switch self {
        case .getWeekly:
            return URLConst.weeklyStats
        }
    }

    var method: Moya.Method {
        switch self {
        case .getWeekly:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getWeekly:
            return .requestPlain
        }
    }
}
