//
//  MonthlyTopStatsViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/23.
//

import UIKit

final class MonthlyTopStatsViewController: BaseViewController {
    
    private let backButton = BaseButton().then {
        $0.setImage(UIImage(named: "backButton"), for: .normal)
    }
    
    private let detailStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 11
    }
    
    private let detailCategorySaveTextLabel1 = UILabel().then {
        $0.text = "99일엔"
        $0.font = UIFont.systemFont(ofSize: 24,
                                    weight: .semibold)
        $0.textColor = .akkinBlack
    }
    
    private let detailCategorySaveTextLabel2 = UILabel().then {
        $0.text = "총 10000원을 아꼈어요"
        $0.font = UIFont.systemFont(ofSize: 20,
                                    weight: .semibold)
        $0.textColor = .akkinGreen
    }
    
    private let monthlyTopStatsCollectionView = MonthlyTopStatsCollectionView()
    
    private let detailCategoryScrollView = UIScrollView()
    
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
        navigationItem.title = "상세 카테고리"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: backButton)
    }
    
    private func setLabelColor() {
        guard let text = detailCategorySaveTextLabel2.text else {
            return
        }

        let attributedText = NSMutableAttributedString(string: text)

        let range = (text as NSString).range(of: "원을 아꼈어요")
        attributedText.addAttribute(.foregroundColor, value: UIColor.akkinBlack, range: range)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .semibold), range: range)

        detailCategorySaveTextLabel2.attributedText = attributedText
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        setLabelColor()
        
        view.addSubview(detailStackView)
        detailStackView.addArrangedSubview(detailCategorySaveTextLabel1)
        detailStackView.addArrangedSubview(detailCategorySaveTextLabel2)
        view.addSubview(detailCategoryScrollView)
        detailCategoryScrollView.addSubview(monthlyTopStatsCollectionView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        detailStackView.snp.makeConstraints {
            $0.top
                .equalTo(view.safeAreaLayoutGuide)
                .inset(20)
            $0.leading
                .equalToSuperview()
                .inset(24)
        }
        
        detailCategoryScrollView.snp.makeConstraints {
            $0.top
                .equalTo(detailStackView.snp.bottom)
                .offset(38)
            $0.width
                .equalToSuperview()
            $0.bottom
                .equalToSuperview()
            $0.centerX
                .equalToSuperview()
        }
        monthlyTopStatsCollectionView.snp.makeConstraints {
            $0.top
                .equalTo(detailCategoryScrollView.snp.top)
            $0.width
                .equalTo(342)
            $0.height
                .equalTo(657)
            $0.centerX
                .equalToSuperview()
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
