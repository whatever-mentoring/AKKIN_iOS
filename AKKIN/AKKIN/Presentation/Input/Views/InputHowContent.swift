//
//  InputHowContent.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit

class InputHowContent: UIView, UITextFieldDelegate {
    
    // MARK: UI Components
    private let howStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    private let howLabel = UILabel().then {
        $0.text = "어떻게 아꼈는지"
        $0.font = .systemFont(
            ofSize: 16, weight: .semibold
        )
    }
    private let howTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "어떤 방식으로 아끼셨나요?"
        textField.font = .systemFont(
            ofSize: 14, weight: .regular
        )
        return textField
    }()
    
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
        addSubview(howStackView)
        howStackView.addArrangedSubview(howLabel)
        howStackView.addArrangedSubview(howTextField)
    }
    
    // MARK: Layout
    func makeConstraints() {
        howTextField.delegate = self
        // let safeArea = self.safeAreaLayoutGuide
        howStackView.snp.makeConstraints {
            $0.top
                .equalToSuperview()
        }
        howTextField.snp.makeConstraints {
            $0.width
                .equalTo(294)
        }
    }
}

