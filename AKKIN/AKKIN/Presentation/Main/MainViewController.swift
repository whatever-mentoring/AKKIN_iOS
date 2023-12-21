//
//  MainViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/13.
//

import UIKit

final class MainViewController: BaseViewController {

    // MARK: UI Components
    private let navigationTitleImageView = UIImageView().then {
        $0.image = AkkinImage.akkinTitle
    }

    private let myPageButton = BaseButton().then {
        $0.setImage(AkkinButton.myPageButton, for: .normal)
    }

    let mainCardCollectionView = MainCardCollectionView()
    let mainGalleryCollectionView = MainGalleryCollectionView()

    // MARK: Environment
    private let router = ExampleRouter()
    private let provider = ExampleProvider(session: .default)

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()

        router.viewController = self
        view.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(mainCardCollectionView)
        view.addSubview(mainGalleryCollectionView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        mainCardCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(345)
        }

        mainGalleryCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainCardCollectionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: View Transition
    override func viewTransition() {
        myPageButton.tap = { [weak self] in
            guard let self else { return }
            router.presentMyPageViewController()
        }

        mainCardCollectionView.tapAdd = { [self] in
            router.presentInputViewController()
        }

        mainCardCollectionView.tapCell = { [self] selectedTodayEntries in
            router.presentCardDetailViewController(selectedTodayEntries: selectedTodayEntries)
        }

//        mainGalleryCollectionView.tapCell = { [self] in
//            router.presentCardDetailViewController(id: 0)
//        }
    }

    private func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: myPageButton)
    }
}
