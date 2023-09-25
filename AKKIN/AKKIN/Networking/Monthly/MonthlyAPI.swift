//
//  MonthlyAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

import Moya
import Foundation

enum MonthlyAPI {
    case getMonthly
}

extension MonthlyAPI: TargetType {
    var path: String {
        switch self {
        case .getMonthly:
            return URLConst.monthlyStats
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMonthly:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getMonthly:
            return .requestPlain
        }
    }
}
