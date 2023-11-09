//
//  MainResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

struct MainResponse: Codable {
    let month: Int
    let weekOfMonth: Int
    let weeklyTotalCost: Int
    let monthlyDining: Int
    let monthlyTraffic: Int
    let monthlyShopping: Int
    let monthlyEtc: Int
    let monthlyTotalCost: Int
    let entries: [MainEntries]
}

struct MainEntries: Codable {
    let id: Int
    let expectCost: Int
    let realCost: Int
    let saveContent: String
    let how: String
}
