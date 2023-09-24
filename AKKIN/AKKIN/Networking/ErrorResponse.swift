//
//  ErrorResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/24.
//

struct ErrorResponse: Codable {
    let timeStamp: String?
    let status: Int?
    let error: String?
    let message: String?
}
