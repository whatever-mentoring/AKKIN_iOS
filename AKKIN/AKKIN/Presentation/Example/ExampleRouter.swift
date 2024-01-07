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

    func presentCardDetailViewController(selectedEntries: [MainEntries]) {
        let cardDetailViewController = CardDetailViewController()
        cardDetailViewController.selectedEntries = selectedEntries

        viewController?.navigationController?.pushViewController(cardDetailViewController, animated: true)
    }

    func presentCardPatchViewController(selectedEntries: [MainEntries]) {
        let cardPatchViewController = CardPatchViewController()
        cardPatchViewController.selectedEntries = selectedEntries

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
        
    func presentCardSaveViewController() {
        let cardSaveViewController = CardSaveViewController()
        cardSaveViewController.modalPresentationStyle = .fullScreen
        viewController?.present(cardSaveViewController, animated: true)
    }

    func dismissCardSaveViewController() {
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
