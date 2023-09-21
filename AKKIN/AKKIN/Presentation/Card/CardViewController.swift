//
//  CardViewController.swift
//  AKKIN
//
//  Created by SJW on 2023/09/16.
//

import UIKit

class CardViewController: BaseViewController {
    
    // MARK: UI Components
    private let cardPageView = CardPageView()
    
    // MARK: Environment
    private let router = ExampleRouter()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .akkinGray0
        router.viewController = self
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        view.addSubview(cardPageView)

        cardPageView.tap = { [weak self] in
            guard let self else { return }
            router.popToRootViewController()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        cardPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
}
