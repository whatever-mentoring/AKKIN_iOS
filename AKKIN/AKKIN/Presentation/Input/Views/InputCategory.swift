//
//  InputCategory.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

enum Category: CaseIterable {
    case DINING, TRAFFIC, SHOPPING, ETC
    
    var title: String {
        switch self {
        case .DINING: return "식비"
        case .TRAFFIC: return "교통"
        case .SHOPPING: return "쇼핑"
        case .ETC: return "기타"
        }
    }
}

final class InputCategory: UIView {
    
    var onCategoryTapped: ((Category) -> Void)?
    public var selectedCategory: String?
    
    // MARK: UI Components
    private let categoryStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
    }
    
    private let categorySelectedStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 8
    }
    
    var buttons = [CategoryButton]()
    
    private let categoryLabel = UILabel().then {
        $0.text = "카테고리"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private let categoryDiscriptionLabel = UILabel().then {
        $0.text = "(1개의 소비 카테고리를 선택해주세요.)"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .akkinGreen
    }
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
        makeConstraints()
        iconButtonSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    func configureSubviews() {
        addSubview(categoryStackView)
        categoryStackView.addArrangedSubview(categoryLabel)
        categoryStackView.addArrangedSubview(categoryDiscriptionLabel)
        addSubview(categorySelectedStackView)
    }
    
    // MARK: Properties
    func iconButtonSetup() {
        self.buttons = Category.allCases.map { category in
            let button = CategoryButton(category: category)
            button.layer.cornerRadius = 15
            button.setTitle(category.title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
            button.backgroundColor = .akkinWhite
            button.setTitleColor(UIColor.akkinBlack, for: .normal)
            button.layer.shadowColor = UIColor.akkinGray1.cgColor
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 4
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.snp.makeConstraints {
                $0.width.equalTo(48)
                $0.height.equalTo(33)
            }
            return button
        }
    
        for button in buttons {
            categorySelectedStackView.addArrangedSubview(button)
            button.addAction(UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                self.onCategoryTapped?(button.category)
                self.setHighlightedState(button.category)
            }), for: .touchUpInside)
        }
    }
    
    func setHighlightedState(_ category: Category) {
        for button in buttons {
            if button.category == category {
                print("\(category)")
                selectedCategory = "\(category)"
                button.setTitleColor(UIColor.akkinWhite, for: .normal)
                button.backgroundColor = .akkinGreen
            }
            else {
                button.setTitleColor(UIColor.akkinBlack, for: .normal)
                button.backgroundColor = .akkinWhite
            }
        }
    }
    
    // MARK: Layout
    func makeConstraints() {
        categoryStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(216)
        }
        categorySelectedStackView.snp.makeConstraints {
            $0.top.equalTo(categoryStackView.snp.bottom).offset(8)
            $0.width.equalTo(216)
        }
    }
}
