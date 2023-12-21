//
//  AkkinAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

import Moya
import Foundation

enum AkkinAPI {
    case getAkkin
    case postAkkin(
        year: Int,
        month: Int,
        day: Int,
        category: String,
        saveContent: String,
        how: String,
        expectCost: Int,
        realCost: Int
    )
    case patchAkkin(
        id: Int,
        year: Int,
        month: Int,
        day: Int,
        category: String,
        saveContent: String,
        how: String,
        expectCost: Int,
        realCost: Int
    )
    case deleteAkkin(id: Int)
}

extension AkkinAPI: TargetType {
    var path: String {
        switch self {
        case .getAkkin:
            return URLConst.gulbis
        case .postAkkin:
            return URLConst.gulbis
        case .patchAkkin:
            return URLConst.gulbis
        case let .deleteAkkin(id):
            return URLConst.gulbis + "/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getAkkin:
            return .get
        case .postAkkin:
            return .post
        case .patchAkkin:
            return .patch
        case .deleteAkkin:
            return .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case .getAkkin, .patchAkkin, .deleteAkkin:
            return .requestPlain
        case .postAkkin(
            let year,
            let month,
            let day,
            let category,
            let saveContent,
            let how,
            let expectCost,
            let realCost
        ):
            return .requestParameters(parameters: [
                "year": year,
                "month": month,
                "day": day,
                "category": category,
                "saveContent": saveContent,
                "how": how,
                "expectCost": expectCost,
                "realCost": realCost
            ], encoding: JSONEncoding.default)
        }
    }
}
