//
//  InputViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit
import SnapKit

class InputViewController: BaseViewController, UITextFieldDelegate {

    // MARK: Constants
    private var isKeyboardVisible = false

    // MARK: UI Components
    private let scrollView = UIScrollView().then {
        $0.delaysContentTouches = false
    }

    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

    private let inputIconSelectedView = InputIconSelectedView()

    private let imageView = UIImageView().then {
        $0.backgroundColor = .akkinWhite
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let inputDatePicker = InputDatePicker()
    private let inputCategory = InputCategory()
    private let inputSaveContent = InputSaveContent()
    private let inputHowContent = InputHowContent()
    private let inputCostContent = InputCostContent()

    private let makeCardButton = BaseButton().then {
        $0.setTitle(AkkinString.makeGulbis, for: .normal)
        $0.titleLabel?.font =
            .systemFont(ofSize: 20, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .akkinGreen
        $0.layer.cornerRadius = 16
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        inputDatePicker
            .translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(inputIconSelectedView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(inputDatePicker)
        scrollView.addSubview(inputCategory)
        scrollView.addSubview(inputSaveContent)
        scrollView.addSubview(inputHowContent)
        scrollView.addSubview(inputCostContent)
        scrollView.addSubview(makeCardButton)
    }
  
    // MARK: Environment
    private let router = ExampleRouter()

    // MARK: Properties
    private func setNavigationItem() {
        navigationItem.title = AkkinString.postGulbis
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(customView: backButton)
    }

    func tapIcon(_ icon: Icon) {
        switch icon {
        case .iconThemeProfile1:
            imageView.image = AkkinImage.akkinImage1
        case .iconThemeProfile2:
            imageView.image = AkkinImage.akkinImage2
        case .iconThemeProfile3:
            imageView.image = AkkinImage.akkinImage3
        case .iconThemeProfile4:
            imageView.image = AkkinImage.akkinImage4
        case .iconThemeProfile5:
            imageView.image = AkkinImage.akkinImage5
        case .iconThemeProfile6:
            imageView.image = AkkinImage.akkinIcon6
        }
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        setupKeyboardEvent()
        setTextFieldDelegate()
        hideKeyboard()
        router.viewController = self
        view.backgroundColor = .akkinBG
    }

    private func setTextFieldDelegate() {
        inputSaveContent.contentTextField.delegate = self
        inputHowContent.howTextField.delegate = self
        inputCostContent.expectCostTextField.delegate = self
        inputCostContent.realCostTextField.delegate = self
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        inputIconSelectedView.snp.makeConstraints {
            $0.top.equalTo(scrollView.safeAreaLayoutGuide).offset(11)
            $0.height.equalTo(44)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(172)
            $0.top.equalTo(inputIconSelectedView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }

        inputDatePicker.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(46)
            $0.height.equalTo(47)
            $0.width.equalTo(294)
        }

        inputCategory.snp.makeConstraints {
            $0.top.equalTo(inputDatePicker.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(46)
            $0.height.equalTo(78)
            $0.width.equalTo(216)
        }

        inputSaveContent.snp.makeConstraints {
            $0.top.equalTo(inputCategory.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(46)
            $0.height.equalTo(52)
            $0.width.equalToSuperview()
        }

        inputHowContent.snp.makeConstraints {
            $0.top.equalTo(inputSaveContent.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(46)
            $0.height.equalTo(52)
            $0.width.equalToSuperview()
        }

        inputCostContent.snp.makeConstraints {
            $0.top.equalTo(inputHowContent.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(46)
            $0.height.equalTo(52)
            $0.width.equalToSuperview()
        }

        makeCardButton.snp.makeConstraints {
            $0.top.equalTo(inputCostContent.snp.bottom).offset(28)
            $0.width.equalTo(342)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: View Transition
    override func viewTransition() {
        makeCardButton.tap = { [weak self] in
            guard let self else {
                return }
            postGulbis(
                year: inputDatePicker.selectedYear ?? 0,
                month: inputDatePicker.selectedMonth ?? 0,
                day: inputDatePicker.selectedDay ?? 0,
                imageUrl: inputIconSelectedView.selectedIcon ?? "nil",
                category: inputCategory.selectedCategory ?? AkkinString.dining,
                saveContent: inputSaveContent.contentTextField.text ?? "nil",
                how: inputHowContent.howTextField.text ?? "nil",
                expectCost: Int(inputCostContent.expectCostTextField.text ?? "0") ?? 0,
                realCost: Int(inputCostContent.realCostTextField.text ?? "0") ?? 0)
            presentCardSaveViewControllerWithArgs(
                from: self,
                selectedYear: inputDatePicker.selectedYear,
                selectedMonth: inputDatePicker.selectedMonth,
                selectedDay: inputDatePicker.selectedDay,
                selectedImage: imageView.image,
                selectedSaveContent: inputSaveContent.contentTextField.text,
                selectedHow: inputHowContent.howTextField.text,
                selectedExpectCost: Int(inputCostContent.expectCostTextField.text ?? "0"),
                selectedRealCost: Int(inputCostContent.realCostTextField.text ?? "0")
            )
        }
 
        backButton.tap = { [weak self] in
            guard let self else {
                return }
            router.dismissViewController()
        }

        inputIconSelectedView.onIconTapped = { [weak self] icon in
            guard let self else {
                return }
            tapIcon(icon)
        }

        inputCategory.onCategoryTapped = { [weak self] category in
            guard self != nil else {
                return }
        }
    }

    private func presentCardSaveViewControllerWithArgs(
        from viewController: UIViewController?,
        selectedYear: Int?,
        selectedMonth: Int?,
        selectedDay: Int?,
        selectedImage: UIImage?,
        selectedSaveContent: String?,
        selectedHow: String?,
        selectedExpectCost: Int?,
        selectedRealCost: Int?
    ) {
        let cardSaveiewController = CardSaveViewController()

        cardSaveiewController.selectedYear = selectedYear
        cardSaveiewController.selectedMonth = selectedMonth
        cardSaveiewController.selectedDay = selectedDay
        cardSaveiewController.selectedImage = imageView.image
        cardSaveiewController.selectedSaveContent = selectedSaveContent
        cardSaveiewController.selectedHow = selectedHow
        cardSaveiewController.selectedExpectCost = selectedExpectCost
        cardSaveiewController.selectedRealCost = selectedRealCost

        cardSaveiewController.modalPresentationStyle = .fullScreen
        viewController?.present(cardSaveiewController, animated: true)
    }

    // MARK: Networking
    private func postGulbis(
        year: Int,
        month: Int,
        day: Int,
        imageUrl: String,
        category: String,
        saveContent: String,
        how: String,
        expectCost: Int,
        realCost: Int
    ) {
        print("💸 postGulbis called")
        NetworkService.shared.gulbis.postGulbis(
            year: year,
            month: month,
            day: day,
            imageUrl: imageUrl,
            category: category,
            saveContent: saveContent,
            how: how,
            expectCost: expectCost,
            realCost: realCost
        ) { result in
            switch result {
            case .success(let response):
                guard let data = response as? BlankDataResponse else { return }
                print("🎯 postGulbis success: " + "\(data)")
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .pathErr:
                print("pathErr")
            }
        }
    }
}

extension InputViewController {
    // MARK: Keyboard
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame =
                sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue,
              let currentTextField = UIResponder.currentResponder
                as? UITextField else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        if !isKeyboardVisible {
            if textFieldBottomY > keyboardTopY {
                let textFieldTopY = convertedTextFieldFrame.origin.y
                let newFrame = textFieldTopY - keyboardTopY / 1.1
                view.frame.origin.y -= newFrame
                isKeyboardVisible = true
            }
        }
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            isKeyboardVisible = false
            view.frame.origin.y = 0
        }
    }

    private func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
}
