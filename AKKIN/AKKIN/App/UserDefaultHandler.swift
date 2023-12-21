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

    @UserDefault(key: "appleToken", defaultValue: "")
    static var appleToken: String

    @UserDefault(key: "authorizationCode", defaultValue: "")
    static var authorizationCode: String

    @UserDefault(key: "userEmail", defaultValue: "")
    static var userEmail: String
}
