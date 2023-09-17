//
//  MainViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/13.
//

import UIKit

final class MainViewController: BaseViewController {

    // MARK: UI Components
    private let navigationTitleImageView = UIImageView().then {
        $0.image = UIImage(named: "AKKIN_Title")
    }

    private let myPageButton = BaseButton().then {
        $0.setImage(UIImage(named: "myPageButton"), for: .normal)
    }

    let mainCardCollectionView = MainCardCollectionView()
    let mainWeeklyStatsView = MainWeeklyStatsView()
    let mainMonthlyStatsView = MainMonthlyStatsView()

    // MARK: Environment
    private let router = ExampleRouter()
    private let provider = ExampleProvider(session: .default)

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()

        router.viewController = self
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        viewTransition()

        view.addSubview(mainCardCollectionView)
        view.addSubview(mainWeeklyStatsView)
        view.addSubview(mainMonthlyStatsView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        mainCardCollectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(255)
        }

        mainWeeklyStatsView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(mainCardCollectionView.snp.bottom)
            $0.height.equalTo(150)
        }

        mainMonthlyStatsView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(mainWeeklyStatsView.snp.bottom)
        }
    }

    // MARK: View Transition
    private func viewTransition() {
        myPageButton.tap = { [weak self] in
            guard let self else { return }
            router.presentMyPageViewController()
        }

        mainWeeklyStatsView.tapAdd = { [self] in
            router.presentWeeklyStatsViewController()
        }
    }

    // MARK: Networking
    private func loadSomething() {
        provider.request(.getSomething) { result in
            /// Do Something
        }
    }

    private func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: myPageButton)
    }
}
