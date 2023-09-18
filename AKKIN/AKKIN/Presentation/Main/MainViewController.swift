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

    private let scrollView = UIScrollView()
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
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

        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(mainCardCollectionView)
        contentStackView.addArrangedSubview(mainWeeklyStatsView)
        contentStackView.addArrangedSubview(mainMonthlyStatsView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }

        mainCardCollectionView.snp.makeConstraints {
            $0.height.equalTo(334)
        }

        mainWeeklyStatsView.snp.makeConstraints {
            $0.height.equalTo(150)
        }

        mainMonthlyStatsView.snp.makeConstraints {
            $0.height.equalTo(245)
        }
    }

    // MARK: View Transition
    override func viewTransition() {
        myPageButton.tap = { [weak self] in
            guard let self else { return }
            router.presentMyPageViewController()
        }

        mainCardCollectionView.tapAdd = { [self] in
            router.presentInputViewController()
        }

        mainWeeklyStatsView.tapAdd = { [self] in
            router.presentWeeklyStatsViewController()
        }

        mainMonthlyStatsView.tapAdd = { [self] in
            router.presentMonthlyStatsViewController()
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
