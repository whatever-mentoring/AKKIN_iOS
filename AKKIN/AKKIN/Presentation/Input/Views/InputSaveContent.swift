//
//  InputSaveContent.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

class InputSaveContent: BaseView, UITextFieldDelegate {

    // MARK: UI Components
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 8
    }

    private let contentLabel = UILabel().then {
        $0.text = AkkinString.content
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    public var contentTextField = UITextField().then {
        $0.placeholder = AkkinString.contentPlaceholder
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        contentTextField.delegate = self

        addSubview(contentStackView)
        contentStackView.addArrangedSubview(contentLabel)
        contentStackView.addArrangedSubview(contentTextField)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
        }

        contentTextField.snp.makeConstraints {
            $0.width.equalTo(294)
        }
    }
}
