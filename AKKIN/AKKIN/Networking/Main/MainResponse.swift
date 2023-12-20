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
    let entries: [TodayEntries]
    let lastId: Int
}

struct FirstPage: Codable {
    let entries: [FirstPageEntries]
    let lastId: Int
}

struct TodayEntries: Codable {
    let id: Int
    let year: Int
    let month: Int
    let day: Int
    let category: String
    let saveContent: String
    let how: String
    let expectCost: Int
    let realCost: Int
}

struct FirstPageEntries: Codable {
    let id: Int
    let year: Int
    let month: Int
    let day: Int
    let category: String
    let saveContent: String
    let how: String
    let expectCost: Int
    let realCost: Int
}
