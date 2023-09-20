//
//  MonthlyStatsViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/19.
//

import UIKit

final class MonthlyStatsViewController: BaseViewController {
    private let monthLabel = UILabel().then {
        $0.text = "9월 둘째주"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
}
