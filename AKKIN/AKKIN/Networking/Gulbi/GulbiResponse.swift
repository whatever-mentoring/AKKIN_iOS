//
//  AkkinResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

struct GulbiResponse: Codable {
    let entries: GulbiEntries
    let lastId: Int
}

struct GulbiEntries: Codable {
    let id: Int
    let year: Int
    let month: Int
    let day: Int
    let imageUrl: String?
    let gulbiCategory: String
    let saveContent: String
    let how: String
    let expectCost: Int
    let realCost: Int
}
