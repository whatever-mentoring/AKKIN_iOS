//
//  MonthlyResponse.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/25.
//

struct MonthlyResponse: Codable {
    let dining: Int
    let traffic: Int
    let shopping: Int
    let etc: Int
    let monthRanking: MonthlyRanking
}

struct MonthlyRanking: Codable {
    let firstDay: Int
    let firstAmount: Int
    let secondDay: Int
    let secondAmount: Int
    let thirdDay: Int
    let thirdAmount: Int
}
