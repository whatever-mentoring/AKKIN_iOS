//
//  CardPatchViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

import UIKit
import SnapKit

class CardPatchViewController: BaseViewController {
    var buttons = [CategoryButton]()
    
    // MARK: Constants
    private var isKeyboardVisible = false

    // MARK: UI Components
    private let scrollView = UIScrollView().then {
        $0.delaysContentTouches = false
    }
    
    private let backButton = BaseButton().then {
       $0.setImage(UIImage(named: "backButton"), for: .normal)
    }

    private let confirmButton = BaseButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
    }

    private let inputIconSelectedView = InputIconSelectedView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .akkinWhite
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let inputDatePicker = InputDatePicker()
    private let inputCategory = InputCategory()
    private let inputSaveContent = InputSaveContent()
    private let inputHowContent = InputHowContent()
    private let inputCostContent = InputCostContent()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        setupKeyboardEvent()
        router.viewController = self
        view.backgroundColor = .akkinGray0
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
        scrollView.addSubview(imageView)
        scrollView.addSubview(inputDatePicker)
        scrollView.addSubview(inputCategory)
        scrollView.addSubview(inputSaveContent)
        scrollView.addSubview(inputHowContent)
        scrollView.addSubview(inputCostContent)
        
        confirmButton.tap = { [weak self] in
            guard let self else {
                return }
            // MARK: - 사용자가 입력한 데이터 연결 필요
            print("수정 완료")
//            postAkkin(year: 0, month: 0, day: 0, category: "DINING", saveContent: "dd", how: "ddd", expectCost: 3, realCost: 3)
//            router.presentCardViewController()
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

    // MARK: Properties
    private func setNavigationItem() {
        navigationItem.title = "카드 내용 수정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: confirmButton)
    }

    // MARK: Networking
//    func postAkkin(year: Int, month: Int, day: Int, category: String, saveContent: String, how: String, expectCost: Int, realCost: Int) {
//        NetworkService.shared.akkin.postAkkin(year: year, month: month, day: day, category: category, saveContent: saveContent, how: how, expectCost: expectCost, realCost: realCost) { result in
//            switch result {
//            case .success(let response):
//                guard let data = response as? AkkinResponse else { return }
//                print(data)
//            case .requestErr(let errorResponse):
//                dump(errorResponse)
//                guard let data = errorResponse as? ErrorResponse else { return }
//                print(data)
//            case .serverErr:
//                print("serverErr")
//            case .networkFail:
//                print("networkFail")
//            case .pathErr:
//                print("pathErr")
//            }
//        }
//    }

    private func tapIcon(_ icon: Icon) {
        switch icon {
        case .iconThemeProfile1:
            imageView.image = UIImage(named: "image_1")
        case .iconThemeProfile2:
            imageView.image = UIImage(named: "image_2")
        case .iconThemeProfile3:
            imageView.image = UIImage(named: "image_3")
        case .iconThemeProfile4:
            imageView.image = UIImage(named: "image_4")
        case .iconThemeProfile5:
            imageView.image = UIImage(named: "image_5")
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

extension CardPatchViewController: UITextFieldDelegate {
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
