//
//  ExampleAPI.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import Moya

enum ExampleAPI: TargetType {
    case getSomething
    case postSomething(ExampleRequest)
    
    var path: String {
        switch self {
        case .getSomething:     return "somethings"
        case .postSomething:    return "somethings"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSomething:     return .get
        case .postSomething:    return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getSomething:
            return .requestPlain
        case .postSomething(let request):
            return .requestJSONEncodable(request)
        }
    }
}
