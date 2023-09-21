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
    private let scrollView = UIScrollView()
    
    private let backButton = BaseButton().then {
       $0.setImage(UIImage(named: "backButton"), for: .normal)
   }
    private let inputIconSelectedView = InputIconSelectedView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .akkinGray1
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let inputDatePicker = InputDatePicker()
    private let inputCategory = InputCategory()
    private let inputSaveContent = InputSaveContent()
    private let inputHowContent = InputHowContent()
    private let inputCostContent = InputCostContent()
    
    private let makeCardButton = BaseButton().then {
        $0.setTitle("카드 만들기", for: .normal)
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
        
        makeCardButton.tap = { [weak self] in
            guard let self else {
                return }
            router.presentCardViewController()
        }
        
        backButton.tap = { [weak self] in
            guard let self else {
                return }
            router.dismissViewController()
        }
    }
    
    // MARK: Properties
    private func setNavigationItem() {
        navigationItem.title = "기록하기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // MARK: Environment
    private let router = ExampleRouter()
    
    // MARK: Properties
    private func setNavigationItem() {
        navigationItem.title = "기록하기"
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(customView: backButton)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(
            currentTextField.frame,
            from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
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
    
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        setupKeyboardEvent()
        router.viewController = self
        view.backgroundColor =
            .akkinGray0
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        scrollView.snp.makeConstraints {
            $0.edges
                .equalToSuperview()
        }
        
        inputIconSelectedView.snp.makeConstraints {
            $0.top
                .equalTo(scrollView.safeAreaLayoutGuide)
                .offset(11)
            $0.height
                .equalTo(44)
            $0.centerX
                .equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height
                .equalTo(172)
            $0.top
                .equalTo(inputIconSelectedView.snp.bottom)
                .offset(16)
            $0.centerX
                .equalToSuperview()
        }
        
        inputDatePicker.snp.makeConstraints {
            $0.top
                .equalTo(imageView.snp.bottom)
                .offset(24)
            $0.leading
                .equalToSuperview()
                .offset(46)
            $0.height
                .equalTo(47)
        }
        
        inputCategory.snp.makeConstraints {
            $0.top
                .equalTo(inputDatePicker.snp.bottom)
                .offset(20)
            $0.leading
                .equalToSuperview()
                .offset(46)
            $0.height
                .equalTo(78)
        }
        
        inputSaveContent.snp.makeConstraints {
            $0.top
                .equalTo(inputCategory.snp.bottom)
                .offset(20)
            $0.leading
                .equalToSuperview()
                .offset(46)
            $0.height
                .equalTo(52)
        }
        
        inputHowContent.snp.makeConstraints {
            $0.top
                .equalTo(inputSaveContent.snp.bottom)
                .offset(20)
            $0.leading
                .equalToSuperview()
                .offset(46)
            $0.height
                .equalTo(52)
        }
        
        inputCostContent.snp.makeConstraints {
            $0.top
                .equalTo(inputHowContent.snp.bottom)
                .offset(20)
            $0.leading
                .equalToSuperview()
                .offset(46)
            $0.height
                .equalTo(52)
        }
        
        makeCardButton.snp.makeConstraints {
            $0.top
                .equalTo(inputCostContent.snp.bottom)
                .offset(28)
            $0.width
                .equalTo(342)
            $0.height
                .equalTo(60)
            $0.centerX
                .equalToSuperview()
        }
    }
}
