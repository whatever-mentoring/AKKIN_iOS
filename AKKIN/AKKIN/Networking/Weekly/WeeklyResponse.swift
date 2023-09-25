//
//  WeeklyResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

struct WeeklyResponse: Codable {
    let month: Int
    let weekOfMonth: Int
    let entries: [WeeklyEntries]
}

struct WeeklyEntries: Codable {
    let id: Int
    let saveCost: Int
    let saveContent: String
    let day: Int
}
