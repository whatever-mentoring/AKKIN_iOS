//
//  InputViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/14.
//

import UIKit

class InputViewController: BaseViewController {
    
    // MARK: Constants
    
    // MARK: UI Components
    private let inputIconSelectedView = InputIconSelectedView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .akkinGray
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
        
        view.addSubview(inputIconSelectedView)
        view.addSubview(imageView)
        view.addSubview(inputDatePicker)
        view.addSubview(inputCategory)
        view.addSubview(inputSaveContent)
        view.addSubview(inputHowContent)
        view.addSubview(inputCostContent)
        view.addSubview(makeCardButton)
        
        makeCardButton.tap = { [weak self] in
            guard let self else {
                return
            }
            router.presentCardViewController()
        }
    }
    // MARK: Environment
    private let router = ExampleRouter()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        view.backgroundColor =
            .akkinBackground
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        inputIconSelectedView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(83)
            $0.height.equalTo(44)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(172)
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
