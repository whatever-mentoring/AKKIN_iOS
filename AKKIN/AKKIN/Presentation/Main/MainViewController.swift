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

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMain()
    }

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

        mainCardCollectionView.tapCell = { [self] selectedEntries in
            router.presentCardDetailViewController(selectedEntries: selectedEntries)
        }

        mainGalleryCollectionView.tapCell = { [self] selectedEntries in
            router.presentCardDetailViewController(selectedEntries: selectedEntries)
        }
    }

    private func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: myPageButton)
    }
}

extension MainViewController {
    // MARK: Networking
    private func getMain() {
        print("*** MainViewController - getMain called")
        NetworkService.shared.main.getMain() { result in
            switch result {
            case .success(let response):
                guard let data = response as? MainResponse else { return }
                self.mainCardCollectionView.todayEntries = data.today.entries
                self.mainGalleryCollectionView.totalEntries = data.firstPage.entries
                self.mainCardCollectionView.cardCollectionView.reloadData()
                self.mainGalleryCollectionView.galleryCollectionView.reloadData()
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
}
