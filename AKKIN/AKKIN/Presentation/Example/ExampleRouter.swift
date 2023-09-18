//
//  ExampleRouter.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import UIKit

final class ExampleRouter {
    // MARK: Properties
    weak var viewController: UIViewController?
    
    // MARK: Routing
    func presentSomeViewController() {
        let someViewController = UIViewController()
        someViewController.view.backgroundColor = .white
        viewController?.present(someViewController, animated: true)
    }

    func presentMyPageViewController() {
        let myPageViewController = MyPageViewController()
        viewController?.navigationController?.pushViewController(myPageViewController, animated: true)
    }

    func presentWeeklyStatsViewController() {
        let weeklyStatsViewController = WeeklyStatsViewController()
        viewController?.navigationController?.pushViewController(weeklyStatsViewController, animated: true)
    }

    func presentMonthlyStatsViewController() {
        let monthlyStatsViewController = UIViewController()
        viewController?.navigationController?.pushViewController(monthlyStatsViewController, animated: true)
    }

    func dismissViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
