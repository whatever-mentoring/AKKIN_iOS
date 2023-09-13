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
    
    let mainCardCollectionView = MainCardCollectionView()

    // MARK: Environment
    private let router = ExampleRouter()
    private let provider = ExampleProvider(session: .default)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()

        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(mainCardCollectionView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        mainCardCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: Networking
    private func loadSomething() {
        provider.request(.getSomething) { result in
            /// Do Something
        }
    }

    private func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "myPageButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(myPageButtonTapped))
    }
}
