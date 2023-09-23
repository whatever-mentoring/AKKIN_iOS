//
//  MonthlyDetailCategoryViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/23.
//

import UIKit
import SnapKit

final class MonthlyDetailCategoryViewController: UIViewController {
    private let category: String
    
    // MARK: UI Components
    private let backButton = BaseButton().then {
        $0.setImage(UIImage(named: "backButton"), for: .normal)
    }
    
    private let detailCategorySaveTextLabel1 = UILabel().then {
        $0.text = "식비에서"
        $0.font = UIFont.systemFont(ofSize: 24,
                                    weight: .semibold)
        $0.textColor = .akkinBlack
    }
    
    private let detailCategorySaveTextLabel2 = UILabel().then {
        $0.text = "총 00000원을 아꼈어요"
        $0.font = UIFont.systemFont(ofSize: 20,
                                    weight: .semibold)
        $0.textColor = .akkinGreen
    }
    
    private let monthlyDetailCategoryCollectionView = MonthlyDetailCategoryCollectionView()
    
    private let scrollView = UIScrollView()
    
    // MARK: Environment
    private let router = ExampleRouter()
    private let provider = ExampleProvider(session: .default)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        addAttributesText()
        configureSubviews()
        makeConstraints()
        viewTransition()
        
        view.backgroundColor = .akkinGray0
        monthlyDetailCategoryCollectionView.setCategory(category)
        router.viewController = self
    }
    
    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    private func setNavigationItem() {
        navigationItem.title = "상세 카테고리"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: backButton)
    }
    
    private func addAttributesText() {
        let labelText = "총 1000000원을 아꼈어요"
        let attributedText = NSMutableAttributedString(string: labelText)

        if let rangeOfTotal = labelText.range(of: "총 "),
           let rangeOfWon = labelText.range(of: "원") {
            let startIndex = rangeOfTotal.upperBound
            let endIndex = rangeOfWon.lowerBound
            let greenAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.akkinGreen,
            ]
            attributedText.addAttributes(greenAttributes, range: NSRange(startIndex..<endIndex, in: labelText))
        }
        let blackAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.akkinBlack,
        ]
        if let rangeOfWon = labelText.range(of: "원") {
            let startIndex = rangeOfWon.upperBound
            let endIndex = labelText.endIndex
            attributedText.addAttributes(blackAttributes, range: NSRange(startIndex..<endIndex, in: labelText))
        }
        detailCategorySaveTextLabel2.attributedText = attributedText
    }
    
    // MARK: Configuration
   func configureSubviews() {
        view.addSubview(detailCategorySaveTextLabel1)
        view.addSubview(detailCategorySaveTextLabel2)
        view.addSubview(monthlyDetailCategoryCollectionView)
    }
    
    // MARK: Layout
    func makeConstraints() {
        detailCategorySaveTextLabel1.snp.makeConstraints {
            $0.top
                .equalTo(view.safeAreaLayoutGuide)
                .inset(20)
            $0.leading
                .equalToSuperview()
                .inset(24)
        }
        detailCategorySaveTextLabel2.snp.makeConstraints {
            $0.top
                .equalTo(detailCategorySaveTextLabel1.snp.bottom)
                .offset(11)
            $0.leading
                .equalToSuperview()
                .inset(24)
        }
        monthlyDetailCategoryCollectionView.snp.makeConstraints {
            $0.top
                .equalTo(detailCategorySaveTextLabel2.snp.bottom)
                .offset(38)
            $0.leading.trailing
                .equalToSuperview()
                .inset(24)
        }
    }
    
    // MARK: View Transition
    func viewTransition() {
        backButton.tap = { [weak self] in
            guard let self else { return }
            router.dismissViewController()
        }
    }
}
