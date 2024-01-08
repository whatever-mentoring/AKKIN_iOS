//
//  InputCostContent.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit

class InputCostContent: BaseView, UITextFieldDelegate {

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

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(costStackView)
        costStackView.addArrangedSubview(expectCostStackView)
        costStackView.addArrangedSubview(realCostStackView)

        expectCostStackView.addArrangedSubview(expectCostLabel)
        expectCostStackView.addArrangedSubview(expectCostTextField)

        realCostStackView.addArrangedSubview(realCostLabel)
        realCostStackView.addArrangedSubview(realCostTextField)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

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
