//
//  InputDatePicker.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

class InputDatePicker: UIView {
    
    // MARK: UI Components
    private let dateLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let dateNameLabel = UILabel().then {
        $0.text = "날짜"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "YYYY / MM / DD"
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    let toolbar = UIToolbar().then {
        $0.sizeToFit()
    }
        
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.locale = Locale(identifier: "ko-KR")
        picker.timeZone = .autoupdatingCurrent
        return picker
    }()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
        makeConstraints()
        createDatePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    func configureSubviews() {
        addSubview(dateLabelStackView)
        dateLabelStackView.addArrangedSubview(dateNameLabel)
        dateLabelStackView.addArrangedSubview(dateTextField)
    }
    
    func creatToolbar() -> UIToolbar { // custom Toolbar 만들기
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }
    
    func createDatePicker() {
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = creatToolbar()
   }
        
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.endEditing(true)
    }
    
    // MARK: Layout
    func makeConstraints() {
        dateLabelStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
    }
}
