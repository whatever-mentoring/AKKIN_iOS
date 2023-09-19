//
//  InputCostContent.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit

class InputCostContent: UIView, UITextFieldDelegate {
    
    // MARK: UI Components
    
    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 24
        $0.alignment = .fill
    }
    private let bottomStackView1 = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    private let expectCostLabel = UILabel().then {
        $0.text = "예상 비용"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    private let expectCostTextField = UITextField().then {
        $0.placeholder = "100,000,000"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    private let bottomStackView2 = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    private let realCostLabel = UILabel().then {
        $0.text = "실제 비용"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    private let realCostTextField = UITextField().then {
        $0.placeholder = "100,000,000"
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
        
        addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(bottomStackView1)
        bottomStackView.addArrangedSubview(bottomStackView2)
        
        bottomStackView1.addArrangedSubview(expectCostLabel)
        bottomStackView1.addArrangedSubview(expectCostTextField)
        
        bottomStackView2.addArrangedSubview(realCostLabel)
        bottomStackView2.addArrangedSubview(realCostTextField)
    }
    
    // MARK: Layout
    func makeConstraints() {
        bottomStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(270)
        }
        bottomStackView1.snp.makeConstraints {
            $0.width.equalTo(123)
        }
        bottomStackView2.snp.makeConstraints {
            $0.width.equalTo(123)
        }
    }
}
