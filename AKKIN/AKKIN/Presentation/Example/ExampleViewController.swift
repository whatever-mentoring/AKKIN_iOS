//
//  ExampleViewController.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import UIKit

final class ExampleViewController: BaseViewController {
    
    // MARK: Constants
    private enum Metric {
        static let labelHeight = 50
        static let buttonHeight = 30
    }
    
    // MARK: UI Components
    private let containerView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private let exampleLable = UILabel().then {
        $0.text = "테스트 문구"
    }
    
    private let exampleButton = BaseButton().then {
        $0.setTitle("다음 화면으로 넘어감", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
    }
    
    private let customView = ExampleCustomView()
    
    // MARK: Environment
    private let router = ExampleRouter()
    private let provider = ExampleProvider(session: .default)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        router.viewController = self
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(containerView)
        containerView.addArrangedSubview(exampleLable)
        containerView.addArrangedSubview(exampleButton)
        containerView.addArrangedSubview(customView)
        
        exampleButton.tap = { [weak self] in
            guard let self else { return }
            router.presentSomeViewController()
        }
        
        customView.tapAdd = {[weak self] in
            guard let self else { return }
            loadSomething()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        exampleButton.snp.makeConstraints { make in
            make.height.equalTo(Metric.buttonHeight)
        }
        
        exampleLable.snp.makeConstraints { make in
            make.height.equalTo(Metric.labelHeight)
        }
    }
    
    // MARK: Networking
    private func loadSomething() {
        provider.request(.getSomething) { result in
            /// Do Something
        }
    }
}
