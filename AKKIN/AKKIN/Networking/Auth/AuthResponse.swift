//
//  AppleLoginResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/11/27.
//

struct AuthLoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
