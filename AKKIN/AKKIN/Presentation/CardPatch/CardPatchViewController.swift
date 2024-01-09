//
//  CardPatchViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

import UIKit
import SnapKit

class CardPatchViewController: BaseViewController, UITextFieldDelegate {

    var buttons = [CategoryButton]()
    var selectedEntries: [MainEntries] = []

    // MARK: Constants
    private var isKeyboardVisible = false

    // MARK: UI Components
    private let scrollView = UIScrollView().then {
        $0.delaysContentTouches = false
    }

    private let backButton = BaseButton().then {
        $0.setImage(AkkinButton.backButton, for: .normal)
    }

    private let confirmButton = BaseButton().then {
        $0.setTitle(AkkinString.confirm, for: .normal)
        $0.setTitleColor(UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
    }

    private let inputIconSelectedView = InputIconSelectedView()

    private let cardImageView =  UIImageView().then {
        $0.backgroundColor = .akkinWhite
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let inputDatePicker = InputDatePicker()
    private let inputCategory = InputCategory()
    private let inputSaveContent = InputSaveContent()
    private let inputHowContent = InputHowContent()
    private let inputCostContent = InputCostContent()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
        setNavigationItem()
        setupKeyboardEvent()
        setTextFieldDelegate()
        router.viewController = self
        view.backgroundColor = .akkinBG
    }

    private func setTextFieldDelegate() {
        inputSaveContent.contentTextField.delegate = self
        inputHowContent.howTextField.delegate = self
        inputCostContent.expectCostTextField.delegate = self
        inputCostContent.realCostTextField.delegate = self
    }

    private func setContent() {
        if selectedEntries[0].imageUrl == "icon_1" {
            inputIconSelectedView.onIconTapped?(Icon.iconThemeProfile1)
            inputIconSelectedView.setHighlightedState(Icon.iconThemeProfile1)
        } else if selectedEntries[0].imageUrl == "icon_2"  {
            inputIconSelectedView.onIconTapped?(Icon.iconThemeProfile2)
            inputIconSelectedView.setHighlightedState(Icon.iconThemeProfile2)
        } else if selectedEntries[0].imageUrl == "icon_3"  {
            inputIconSelectedView.onIconTapped?(Icon.iconThemeProfile3)
            inputIconSelectedView.setHighlightedState(Icon.iconThemeProfile3)
        } else if selectedEntries[0].imageUrl == "icon_4" {
            inputIconSelectedView.onIconTapped?(Icon.iconThemeProfile4)
            inputIconSelectedView.setHighlightedState(Icon.iconThemeProfile4)
        } else if selectedEntries[0].imageUrl == "icon_5" {
            inputIconSelectedView.onIconTapped?(Icon.iconThemeProfile5)
            inputIconSelectedView.setHighlightedState(Icon.iconThemeProfile5)
        } else {
            print("imageUrl is nil")
        }

        if selectedEntries[0].gulbiCategory == AkkinString.DINING {
            inputCategory.onCategoryTapped?(Category.DINING)
            inputCategory.setHighlightedState(Category.DINING)
        } else if selectedEntries[0].gulbiCategory == AkkinString.TRAFFIC {
            inputCategory.onCategoryTapped?(Category.TRAFFIC)
            inputCategory.setHighlightedState(Category.TRAFFIC)
        } else if selectedEntries[0].gulbiCategory == AkkinString.SHOPPING {
            inputCategory.onCategoryTapped?(Category.SHOPPING)
            inputCategory.setHighlightedState(Category.SHOPPING)
        } else if selectedEntries[0].gulbiCategory == AkkinString.ETC {
            inputCategory.onCategoryTapped?(Category.ETC)
            inputCategory.setHighlightedState(Category.ETC)
        } else {
            print("category is nil" + "\(selectedEntries[0].gulbiCategory)")
        }

        inputDatePicker.dateTextField.text = "\(selectedEntries[0].year)" + " / " + "\(selectedEntries[0].month)" + " / " + "\(selectedEntries[0].day)"
        inputSaveContent.contentTextField.text = selectedEntries[0].saveContent
        inputHowContent.howTextField.text = selectedEntries[0].how
        inputCostContent.expectCostTextField.text = "\(selectedEntries[0].expectCost.toPriceFormat)"
        inputCostContent.realCostTextField.text = "\(selectedEntries[0].realCost.toPriceFormat)"
    }

    // MARK: Environment
    private let router = ExampleRouter()

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        inputDatePicker
            .translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(inputIconSelectedView)
        scrollView.addSubview(cardImageView)
        scrollView.addSubview(inputDatePicker)
        scrollView.addSubview(inputCategory)
        scrollView.addSubview(inputSaveContent)
        scrollView.addSubview(inputHowContent)
        scrollView.addSubview(inputCostContent)

        confirmButton.tap = { [weak self] in
            guard let self else {
                return }

            patchGulbis(
                id: selectedEntries[0].id,
                year: selectedEntries[0].year,
                month: selectedEntries[0].month,
                day: selectedEntries[0].day,
                imageUrl: selectedEntries[0].imageUrl ?? "icon_1",
                category: selectedEntries[0].gulbiCategory,
                saveContent: selectedEntries[0].saveContent,
                how: selectedEntries[0].how,
                expectCost: selectedEntries[0].expectCost,
                realCost: selectedEntries[0].realCost
            )

            router.dismissViewController()
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

    // MARK: Navigation Item
    private func setNavigationItem() {
        navigationItem.title = AkkinString.patchGulbisTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: confirmButton)
    }

    // MARK: Networking
    func patchGulbis(
        id: Int,
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
        print("💸 patchGulbis called")
        NetworkService.shared.gulbis.patchGulbis(
            id: id,
            year: year,
            month: month,
            day: day,
            imageUrl: imageUrl,
            category: category,
            saveContent: saveContent,
            how: how,
            expectCost: expectCost,
            realCost: realCost
        ) { [self] result in
            switch result {
            case .success:
                print("🎯 patchGulbis success")
                router.dismissViewController()
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

    private func tapIcon(_ icon: Icon) {
        switch icon {
        case .iconThemeProfile1:
            cardImageView.image = AkkinImage.akkinImage1
        case .iconThemeProfile2:
            cardImageView.image = AkkinImage.akkinImage2
        case .iconThemeProfile3:
            cardImageView.image = AkkinImage.akkinImage3
        case .iconThemeProfile4:
            cardImageView.image = AkkinImage.akkinImage4
        case .iconThemeProfile5:
            cardImageView.image = AkkinImage.akkinImage5
        }
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

        cardImageView.snp.makeConstraints {
            $0.width.height.equalTo(172)
            $0.top.equalTo(inputIconSelectedView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }

        inputDatePicker.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(46)
            $0.height.equalTo(47)
            $0.width.equalTo(294)
        }

        inputCategory.snp.makeConstraints {
            $0.top.equalTo(inputDatePicker.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(46)
            $0.height.equalTo(78)
            $0.width.equalTo(272)
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
    }
}

// MARK: Keyboard
extension CardPatchViewController {
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame =
                sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue,
              let currentTextField = UIResponder.currentResponder
                as? UITextField else { return }

        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(
            currentTextField.frame,
            from: currentTextField.superview)
        let textFieldBottomY =
        convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        if textFieldBottomY > keyboardTopY {
            let textFieldTopY = convertedTextFieldFrame.origin.y
            let newFrame = textFieldTopY - keyboardTopY/1.08
            view.frame.origin.y -= newFrame
        }
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
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
