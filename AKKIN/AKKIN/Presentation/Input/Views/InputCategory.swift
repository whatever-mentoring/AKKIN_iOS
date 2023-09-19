//
//  InputCategory.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

final class CategoryButton: UIButton {
    var tap: ((CategoryButton) -> Void)?
    
    let category: Category
    init(category: Category) {
        self.category = category
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum Category: CaseIterable {
    case categoryProfile1, categoryProfile2, categoryProfile3, categoryProfile4, categoryProfile5
    
    var title: String {
        switch self {
        case .categoryProfile1: return "식비"
        case .categoryProfile2: return "교통"
        case .categoryProfile3: return "쇼핑"
        case .categoryProfile4: return "취미"
        case .categoryProfile5: return "기타"
        }
    }
}

final class InputCategory: UIView {
    
    // MARK: UI Components
    private let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    private let categorySelectedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    var categoryButtons = [CategoryButton]()
    
    private let categoryLabel = UILabel().then {
        $0.text = "카테고리"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private let categoryDiscriptionLabel = UILabel().then {
        $0.text = "(1개 이상의 소비 카테고리를 선택해주세요.)"
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
        let items = Category.allCases.map { category in
            let button = CategoryButton(category: category)
            button.layer.cornerRadius = 15
            button.setTitle(category.title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
            button.setTitleColor(UIColor.akkinBlack, for: .normal)
            button.backgroundColor = .white
            button.layer.shadowColor = UIColor.akkinShadow.cgColor
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 4
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.snp.makeConstraints {
                $0.width.equalTo(48)
                $0.height.equalTo(33)
            }
            return button
        }
    
        for button in items {
            categorySelectedStackView.addArrangedSubview(button)
            button.tap = { [weak self] categoryType in
                guard let self else { return }
                tapIcon(categoryType.category)
            }
        }
    }
    
    func tapIcon(_ category: Category) {
    }
    
    // MARK: Layout
    func makeConstraints() {
        categoryStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(272)
        }
        categorySelectedStackView.snp.makeConstraints {
            $0.top.equalTo(categoryStackView.snp.bottom).offset(8)
            $0.width.equalTo(272)
        }
    }
}
