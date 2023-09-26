//
//  MonthlyStatsViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/19.
//

import UIKit

final class MonthlyStatsViewController: BaseViewController {
    private let monthLabel = UILabel().then {
        $0.text = "9월"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    private let bestCategoryImageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.akkinGray3.cgColor
        $0.layer.cornerRadius = 8
    }
    
    private let monthlySaveText = UILabel().then {
        $0.text = "총 100,000,000원 아꼈어요"
        $0.font = UIFont.systemFont(ofSize: 26,
                                    weight: .semibold)
        $0.textColor = .akkinGreen
    }
    
    private let previousButton = BaseButton().then {
        $0.setImage(AkkinButton.previousButton, for: .normal)
    }

    private let nextButton = BaseButton().then {
        $0.setImage(AkkinButton.detailButton, for: .normal)
    }
    
    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }
    
    private let scrollView = UIScrollView()
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
    }
    
    let monthlyDetailCategoryView = MonthlyDetailCategoryView()
    let monthlyTopStatsView = MonthlyTopStatsView()
    
    // MARK: Environment
    private let router = ExampleRouter()
    private let provider = ExampleProvider(session: .default)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        view.backgroundColor = .akkinGray0

        router.viewController = self
    }
    
    // MARK: Properties
    private func setNavigationItem() {
        navigationItem.title = "월간 통계"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: backButton)
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        router.viewController = self
        view.addSubview(monthLabel)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        view.addSubview(bestCategoryImageView)
        view.addSubview(monthlySaveText)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView
            .addArrangedSubview(monthlyDetailCategoryView)
        contentStackView
            .addArrangedSubview(monthlyTopStatsView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        monthLabel.snp.makeConstraints {
            $0.top
                .equalTo(view.safeAreaLayoutGuide)
                .inset(20)
            $0.centerX
                .equalToSuperview()
        }

        previousButton.snp.makeConstraints {
            $0.trailing
                .equalTo(monthLabel.snp.leading)
                .offset(-10)
            $0.centerY
                .equalTo(monthLabel.snp.centerY)
            $0.width.height
                .equalTo(8)
        }

        nextButton.snp.makeConstraints {
            $0.leading
                .equalTo(monthLabel.snp.trailing)
                .offset(10)
            $0.centerY
                .equalTo(monthLabel.snp.centerY)
            $0.width.height
                .equalTo(8)
        }
        
        bestCategoryImageView.snp.makeConstraints {
            $0.top
                .equalTo(monthLabel.snp.bottom)
                .offset(16)
            $0.height.width
                .equalTo(172)
            $0.centerX
                .equalToSuperview()
        }
        
        monthlySaveText.snp.makeConstraints {
            $0.top
                .equalTo(bestCategoryImageView.snp.bottom)
                .offset(16)
            $0.centerX
                .equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top
                .equalTo(monthlySaveText.snp.bottom)
                .offset(34)
            $0.leading.trailing.bottom
                .equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
        }
        
        monthlyDetailCategoryView.snp.makeConstraints {
            $0.height
                .equalTo(198)
        }
        
        monthlyTopStatsView.snp.makeConstraints {
            $0.height
                .equalTo(168)
        }
    }
    
    // MARK: View Transition
    override func viewTransition() {
        backButton.tap = { [weak self] in
            guard let self else { return }
            router.dismissViewController()
        }
    }
}
