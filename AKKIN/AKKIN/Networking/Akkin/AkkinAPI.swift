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
        imageUrl: String,
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
        imageUrl: String,
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
        case .getAkkin, .deleteAkkin:
            return .requestPlain
        case let .postAkkin(
            year,
            month,
            day,
            imageUrl,
            category,
            saveContent,
            how,
            expectCost,
            realCost
        ):
            return .requestParameters(parameters: [
                "year": year,
                "month": month,
                "day": day,
                "imageUrl": imageUrl,
                "category": category,
                "saveContent": saveContent,
                "how": how,
                "expectCost": expectCost,
                "realCost": realCost
            ], encoding: JSONEncoding.default)
        case let .patchAkkin(
            _,
            year,
            month,
            day,
            imageUrl,
            category,
            saveContent,
            how,
            expectCost,
            realCost
        ):
            return .requestParameters(parameters: [
                "year": year,
                "month": month,
                "day": day,
                "imageUrl": imageUrl,
                "category": category,
                "saveContent": saveContent,
                "how": how,
                "expectCost": expectCost,
                "realCost": realCost
            ], encoding: JSONEncoding.default)
        }
        
    }
}
