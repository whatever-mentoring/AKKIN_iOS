//
//  InputCostContent.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit

class InputCostContent: UIView, UITextFieldDelegate {

    // MARK: UI Components
    private let costStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 24
        $0.alignment = .fill
    }

    private let expectCostStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }

    private let expectCostLabel = UILabel().then {
        $0.text = AkkinString.expect
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    public var expectCostTextField = UITextField().then {
        $0.placeholder = AkkinString.expectPlaceholder
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let realCostStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }

    private let realCostLabel = UILabel().then {
        $0.text = AkkinString.real
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    public var realCostTextField = UITextField().then {
        $0.placeholder = AkkinString.realPlaceholder
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    func configureSubviews() {
        addSubview(costStackView)
        costStackView.addArrangedSubview(expectCostStackView)
        costStackView.addArrangedSubview(realCostStackView)
        
        expectCostStackView.addArrangedSubview(expectCostLabel)
        expectCostStackView.addArrangedSubview(expectCostTextField)
        
        realCostStackView.addArrangedSubview(realCostLabel)
        realCostStackView.addArrangedSubview(realCostTextField)
    }

    // MARK: Layout
    func makeConstraints() {
        costStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(270)
        }
        expectCostStackView.snp.makeConstraints {
            $0.width.equalTo(123)
        }
        realCostStackView.snp.makeConstraints {
            $0.width.equalTo(123)
        }
    }
}
