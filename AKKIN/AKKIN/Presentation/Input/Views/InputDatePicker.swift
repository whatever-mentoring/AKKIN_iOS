
//
//  InputDatePicker.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

class InputDatePicker: BaseView {

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
        $0.text = AkkinString.date
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    public var dateTextField = UITextField().then {
        $0.placeholder = AkkinString.datePlaceholder
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let toolbar = UIToolbar().then {
        $0.sizeToFit()
    }

    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .inline
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(dateLabelStackView)

        dateLabelStackView.addArrangedSubview(dateNameLabel)
        dateLabelStackView.addArrangedSubview(dateTextField)
        createDatePicker()
    }

    // MARK: Properties
    private func creatToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done, target: nil, action: #selector(donePressed)
        )
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }

    private func createDatePicker() {
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
    override func makeConstraints() {
        super.makeConstraints()

        dateLabelStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
    }
}
