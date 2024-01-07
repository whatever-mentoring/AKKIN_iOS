//
//  MainResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

struct MainResponse: Codable {
    let today: Today
    let firstPage: FirstPage
}

struct Today: Codable {
    let entries: [MainEntries]
    let lastId: Int
}

struct FirstPage: Codable {
    let entries: [MainEntries]
    let lastId: Int
}

struct MainEntries: Codable {
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
