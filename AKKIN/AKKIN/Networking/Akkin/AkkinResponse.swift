//
//  AkkinResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

struct AkkinResponse: Codable {
    let id: Int
    let year: Int
    let month: Int
    let day: Int
    let category: String
    let content: String
    let how: String
    let expectCost: Int
    let realCost: Int
}

struct AkkineEntireResponse: Codable {
    let entries: [EntireEntries]
}

struct EntireEntries: Codable {
    let id: Int
    let year: Int
    let month: Int
    let day: Int
    let category: String
    let content: String
    let how: String
    let expectCost: Int
    let realCost: Int
}
