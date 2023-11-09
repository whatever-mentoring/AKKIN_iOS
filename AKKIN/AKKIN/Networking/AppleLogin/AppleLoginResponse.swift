//
//  AppleLoginResponse.swift
//  AKKIN
//
//  Created by 신종원 on 11/9/23.
//

import Foundation
struct AppleLoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
