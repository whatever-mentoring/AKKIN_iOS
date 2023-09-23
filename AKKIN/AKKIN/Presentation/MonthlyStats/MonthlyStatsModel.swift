//
//  MonthlyStatsModel.swift
//  AKKIN
//
//  Created by SJW on 2023/09/24.
//

import Foundation

struct CategoryItem {
    let name: String
    let amount: Int
}

struct MonthlyExpense: Codable {
    let dining: Int
    let traffic: Int
    let shopping: Int
    let etc: Int
    let monthDayRanking: MonthDayRanking

    enum CodingKeys: String, CodingKey {
        case dining
        case traffic
        case shopping
        case etc
        case monthDayRanking
    }
}

struct MonthDayRanking: Codable {
    let firstDay: Int
    let firstAmount: Int
    let secondDay: Int
    let secondAmount: Int
    let thirdDay: Int
    let thirdAmount: Int

    enum CodingKeys: String, CodingKey {
        case firstDay = "firstDay"
        case firstAmount = "firstAmount"
        case secondDay = "secondDay"
        case secondAmount = "secondAmount"
        case thirdDay = "thirdDay"
        case thirdAmount = "thirdAmount"
    }
}
