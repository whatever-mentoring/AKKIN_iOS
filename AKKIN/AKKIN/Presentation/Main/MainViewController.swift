//
//  MainViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/13.
//

import UIKit

final class MainViewController: BaseViewController {
    
    // MARK: Constants
    private enum Metric {
        static let labelHeight = 50
        static let buttonHeight = 30
    }

    private let navigationTitleImageView = UIImageView().then {
        $0.image = UIImage(named: "AKKIN_Title")
    }

    @objc func myPageButtonTapped() {
//        let nextViewController = MyPageViewController()
//        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: Environment
    private let router = ExampleRouter()
    private let provider = ExampleProvider(session: .default)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "myPageButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(myPageButtonTapped))
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

    }
    
    // MARK: Networking
    private func loadSomething() {
        provider.request(.getSomething) { result in
            /// Do Something
        }
    }
}
