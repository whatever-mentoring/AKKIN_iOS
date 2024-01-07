//
//  AkkinAPI.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

import Moya
import Foundation

enum GulbiAPI {
    case getGulbis
    case postGulbis(
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
    case patchGulbis(
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
    case deleteGulbis(id: Int)
}

extension GulbiAPI: TargetType {
    var path: String {
        switch self {
        case .getGulbis:
            return URLConst.gulbis
        case .postGulbis:
            return URLConst.gulbis
        case let .patchGulbis(id, _, _, _, _, _, _, _, _, _):
            return URLConst.gulbis + "/\(id)"
        case let .deleteGulbis(id):
            return URLConst.gulbis + "/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getGulbis:
            return .get
        case .postGulbis:
            return .post
        case .patchGulbis:
            return .patch
        case .deleteGulbis:
            return .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case .getGulbis, .deleteGulbis:
            return .requestPlain
        case let .postGulbis(
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
        case let .patchGulbis(
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
