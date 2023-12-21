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

    func presentLoginViewController() {
        let loginViewController = LoginViewController()
        viewController?.navigationController?.pushViewController(loginViewController, animated: true)
    }

    func presentMainViewController() {
        let mainViewController = MainViewController()
        viewController?.navigationController?.pushViewController(mainViewController, animated: true)
    }

    func presentMyPageViewController() {
        let myPageViewController = MyPageViewController()
        viewController?.navigationController?.pushViewController(myPageViewController, animated: true)
    }

    func presentInputViewController() {
        let inputViewController = InputViewController()
        viewController?.navigationController?.pushViewController(inputViewController, animated: true)
    }

    func presentTodayCardDetailViewController(selectedTodayEntries: [TodayEntries]) {
        let cardDetailViewController = CardDetailViewController()
        cardDetailViewController.selectedTodayEntries = selectedTodayEntries
        cardDetailViewController.selectedTotalEntries = []

        viewController?.navigationController?.pushViewController(cardDetailViewController, animated: true)
    }

    func presentTotalCardDetailViewController(selectedTotalEntries: [FirstPageEntries]) {
        let cardDetailViewController = CardDetailViewController()
        cardDetailViewController.selectedTotalEntries = selectedTotalEntries
        cardDetailViewController.selectedTodayEntries = []

        viewController?.navigationController?.pushViewController(cardDetailViewController, animated: true)
    }

    func presentCardPatchViewController() {
        let cardPatchViewController = CardPatchViewController()
        viewController?.navigationController?.pushViewController(cardPatchViewController, animated: true)
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
        let cardViewController = CardViewController()
        cardViewController.modalPresentationStyle = .fullScreen
        viewController?.present(cardViewController, animated: true)
    }

    func dismissCardViewController() {
        viewController?.dismiss(animated: true, completion: {
            self.viewController?.navigationController?.popToRootViewController(animated: true)
        })
    }

    func popToRootViewController() {
        viewController?.dismiss(animated: true, completion: {
            if let rootViewController =
                UIApplication.shared.windows.first?
                .rootViewController {
                    if let navigationController =
                        rootViewController as? UINavigationController {
                        navigationController
                            .popToRootViewController(animated: true)
                }
            }
        })
    }
}
