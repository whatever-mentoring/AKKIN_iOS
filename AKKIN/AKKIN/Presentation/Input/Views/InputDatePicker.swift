
//
//  InputDatePicker.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

class InputDatePicker: UIView {
    var selectedYear: Int?
    var selectedMonth: Int?
    var selectedDay: Int?
    
    // MARK: UI Components
    private let dateLabelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 8
    }

    private let dateNameLabel = UILabel().then {
        $0.text = "날짜"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    public var dateTextField = UITextField().then {
        $0.placeholder = "YYYY / MM / DD"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    let toolbar = UIToolbar().then {
        $0.sizeToFit()
    }
  
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .inline
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
    }

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

    // MARK: Properties
    func creatToolbar() -> UIToolbar { // custom Toolbar 만들기
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done, target: nil, action: #selector(donePressed)
        )
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
        let calendar = Calendar.current
        selectedYear = calendar.component(.year, from: datePicker.date)
        selectedMonth = calendar.component(.month, from: datePicker.date)
        selectedDay = calendar.component(.day, from: datePicker.date)

        self.endEditing(true)
    }

    // MARK: Layout
    func makeConstraints() {
        dateLabelStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
    }
}
