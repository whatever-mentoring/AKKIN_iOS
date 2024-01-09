//
//  InputHowContent.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit

class InputHowContent: BaseView, UITextFieldDelegate {

    // MARK: UI Components
    private let howStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 8
    }

    private let howLabel = UILabel().then {
        $0.text = AkkinString.how
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    public var howTextField = UITextField().then {
        $0.placeholder = AkkinString.howPlaceholder
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(howStackView)
        howStackView.addArrangedSubview(howLabel)
        howStackView.addArrangedSubview(howTextField)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        howStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
        }

        howTextField.snp.makeConstraints {
            $0.width.equalTo(294)
        }
    }
}

