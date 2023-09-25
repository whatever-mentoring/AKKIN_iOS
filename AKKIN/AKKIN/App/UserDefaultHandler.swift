//
//  UserDefaultHandler.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

struct UserDefaultHandler {
    @UserDefault(key: "accessToken", defaultValue: "")
    static var accessToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: "")
    static var refreshToken: String
}
