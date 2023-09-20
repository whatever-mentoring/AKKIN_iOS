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

    func presentInputViewController() {
        let inputViewController = InputViewController()
        viewController?.navigationController?.pushViewController(inputViewController, animated: true)
    }

    func presentCardDetailViewController() {
        let cardDetailViewController = ExampleViewController()
        viewController?.navigationController?.pushViewController(cardDetailViewController, animated: true)
    }

    func presentWeeklyStatsViewController() {
        let weeklyStatsViewController = WeeklyStatsViewController()
        viewController?.navigationController?.pushViewController(weeklyStatsViewController, animated: true)
    }

    func presentMonthlyStatsViewController() {
        let monthlyStatsViewController = MonthlyStatsViewController()
        viewController?.navigationController?.pushViewController(monthlyStatsViewController, animated: true)
    }

    func dismissViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
        
    func presentCardViewController() {
        let someViewController = CardViewController()
        someViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        viewController?.present(someViewController, animated: true)
    }

    func dismissCardViewController() {
        viewController?.dismiss(animated: true, completion: {
            self.viewController?.navigationController?.popToViewController(MainViewController(),animated: true)
        })
    }

    func popToRootViewController() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
