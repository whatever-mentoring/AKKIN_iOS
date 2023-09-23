//
//  MonthlyDetailCategoryViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/23.
//

import UIKit

final class MonthlyDetailCategoryViewController: BaseViewController {
    
    
    private let backButton = BaseButton().then {
        $0.setImage(UIImage(named: "backButton"), for: .normal)
    }
    
    private let detailCategorySaveTextLabel1 = UILabel().then {
        $0.text = "식비에서"
        $0.font = UIFont.systemFont(ofSize: 24,
                                    weight: .semibold)
        $0.textColor = .akkinGreen
    }
    
    private let detailCategorySaveTextLabel2 = UILabel().then {
        $0.text = "총 00000원을 아꼈어요"
        $0.font = UIFont.systemFont(ofSize: 20,
                                    weight: .semibold)
        $0.textColor = .akkinGreen
    }
    
    private let scrollView = UIScrollView()
    
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
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
    }
}
