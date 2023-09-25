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
       $0.setImage(UIImage(named: "backButton"), for: .normal)
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
    }
    
    // MARK: Environment
    private let router = ExampleRouter()
    
    // MARK: Properties
    private func setNavigationItem() {
        navigationItem.title = "기록하기"
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(customView: backButton)
    }
    
    func tapIcon(_ icon: Icon) {
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
            object: nil)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        setupKeyboardEvent()
        hideKeyboard()
        inputSaveContent.contentTextField.delegate = self
        inputHowContent.howTextField.delegate = self
        inputCostContent.expectCostTextField.delegate = self
        inputCostContent.realCostTextField.delegate = self
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
            $0.width
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
            $0.width
                .equalTo(294)
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
            $0.width
                .equalTo(216)
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
            $0.width
                .equalToSuperview()
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
            $0.width
                .equalToSuperview()
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
            $0.width
                .equalToSuperview()
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
    
    // MARK: View Transition
    override func viewTransition() {
        makeCardButton.tap = { [weak self] in
            guard let self else {
                return }
            postGulbi()
            presentCardViewControllerWithArgs(
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
    func presentCardViewControllerWithArgs(
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
        let cardViewController = CardViewController()
        
        // CardViewController에 전달할 값들을 설정
        cardViewController.selectedYear = selectedYear
        cardViewController.selectedMonth = selectedMonth
        cardViewController.selectedDay = selectedDay
        cardViewController.selectedImage = imageView.image
        cardViewController.selectedSaveContent = selectedSaveContent
        cardViewController.selectedHow = selectedHow
        cardViewController.selectedExpectCost = selectedExpectCost
        cardViewController.selectedRealCost = selectedRealCost
        
        // Modal로 표시
        cardViewController.modalPresentationStyle = .fullScreen
        viewController?.present(cardViewController, animated: true)
    }

    
    // MARK: Networking

    func getDummyToken(completion: @escaping (Result<String, Error>) -> Void) {
        // 더미 토큰을 받을 URL
        guard let url = URL(string: "https://www.example.com/get_data_endpoint") else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // HTTP 응답 코드 확인
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // HTTP 응답이 성공적이지 않은 경우에 대한 처리
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "HTTPError", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let data = data, let token = String(data: data, encoding: .utf8) {
                completion(.success(token))
            } else {
                let error = NSError(domain: "DataParsingError", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func postGulbi() {
        guard
            let year = inputDatePicker.selectedYear,
            let month = inputDatePicker.selectedMonth,
            let day = inputDatePicker.selectedDay,
            let category = inputCategory.selectedCategory,
            let saveContent = inputSaveContent.contentTextField.text,
            let how = inputHowContent.howTextField.text,
            let expectCostText = inputCostContent.expectCostTextField.text,
            let realCostText = inputCostContent.realCostTextField.text,
            let expectCost = Int(expectCostText),
            let realCost = Int(realCostText)
        else {
            // 필요한 값이 모두 유효하지 않을 때 처리
            return
        }
        let gulbi = Gulbis(year: year, month: month, day: day, category: category, saveContent: saveContent, how: how, expectCost: expectCost, realCost: realCost)
        guard let uploadData = try? JSONEncoder().encode(gulbi)
        else {return}
        
        // URL 객체 정의
        let url = URL(string: "https://www.seuleuleug.site/api/gulbis")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        // HTTP 메시지 헤더
        request.setValue("Bearer \(UserDefaultHandler.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in
            
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            // 응답 처리 로직
            print("굴비 post success")
        }
        
        // POST 전송
        task.resume()
    }
}
