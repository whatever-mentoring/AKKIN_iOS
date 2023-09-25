//
//  ExpenseItem.swift
//  AKKIN
//
//  Created by SJW on 2023/09/24.
//

import Foundation

struct Gulbis: Codable {
    let year: Int
    let month: Int
    let day: Int
    let category: String
    let saveContent: String
    let how: String
    let expectCost: Int
    let realCost: Int
}
