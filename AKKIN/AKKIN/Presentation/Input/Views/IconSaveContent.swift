//
//  InputSaveContent.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

class InputSaveContent: UIView, UITextFieldDelegate {
    
    // MARK: UI Components
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 8
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "소비내용"
        $0.font = .systemFont(
            ofSize: 16, weight: .semibold
        )
    }
    let contentTextField = UITextField().then {
        $0.placeholder = "어떤 소비를 했는지 적어보세요."
        $0.font = .systemFont(
            ofSize: 14, weight: .regular
        )
    }
    
    var lineView1 = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 342, height: 1)
        $0.layer.backgroundColor = UIColor.akkinGray2.cgColor
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
        addSubview(contentStackView)
        contentStackView
            .addArrangedSubview(contentLabel)
        contentStackView
            .addArrangedSubview(contentTextField)
    }
    
    // MARK: Layout
    func makeConstraints() {
        contentTextField.delegate = self
        contentStackView.snp.makeConstraints {
            $0.top
                .equalToSuperview()
        }
        contentTextField.snp.makeConstraints {
            $0.width
                .equalTo(294)
        }
    }
}
