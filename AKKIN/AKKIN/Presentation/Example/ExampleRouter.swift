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
        let inputViewController = ExampleViewController()
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
        let monthlyStatsViewController = ExampleViewController()
        viewController?.navigationController?.pushViewController(monthlyStatsViewController, animated: true)
    }

    func dismissViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func presentInputSelectedViewController() {
            let someViewController = InputViewController()
            someViewController.view.backgroundColor = .white
            viewController?.present(someViewController, animated: true)
        }
        
    func presentCardViewController() {
        let someViewController = CardViewController()
        someViewController.view.backgroundColor = .white
        someViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        viewController?.present(someViewController, animated: true)
    }

    func dismissCardViewController() {
        viewController?.dismiss(animated: true)
        //completion 함수 추가하기
    }

    func popToRootViewController() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
