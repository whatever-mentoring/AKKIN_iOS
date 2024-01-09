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

    let loadingContainerView = UIView(frame: UIScreen.main.bounds)
    let loadingView = UIActivityIndicatorView(style: .large)

    let mainCardCollectionView = MainCardCollectionView()
    let mainGalleryCollectionView = MainGalleryCollectionView()

    // MARK: Environment
    private let router = ExampleRouter()

    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        showLoadingView()
        getMain()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItem()
        router.viewController = self
        view.backgroundColor = .akkinBG
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(mainCardCollectionView)
        view.addSubview(mainGalleryCollectionView)
    }

    private func setNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: myPageButton)
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

        mainCardCollectionView.tapCell = { [self] id, selectedEntries in
            router.presentCardDetailViewController(id: id, selectedEntries: selectedEntries)
        }

        mainGalleryCollectionView.tapCell = { [self] id, selectedEntries in
            router.presentCardDetailViewController(id: id, selectedEntries: selectedEntries)
        }
    }

    // MARK: LoadingView
    private func showLoadingView() {
        loadingContainerView.backgroundColor = .white
        loadingView.color = .akkinGray2
        loadingView.center = loadingContainerView.center
        loadingView.startAnimating()

        view.addSubview(loadingContainerView)
        loadingContainerView.addSubview(loadingView)
    }
    
    private func hideLoadingView() {
        loadingView.stopAnimating()
        loadingContainerView.removeFromSuperview()
    }
}

extension MainViewController {
    // MARK: Networking
    private func getMain() {
        print("💸 getMain called")
        NetworkService.shared.main.getMain() { [self] result in
            switch result {
            case .success(let response):
                guard let data = response as? MainResponse else { return }
                print("🎯 getMain success")
                mainCardCollectionView.todayEntries = data.today.entries
                mainGalleryCollectionView.totalEntries = data.firstPage.entries
                mainCardCollectionView.cardCollectionView.reloadData()
                mainGalleryCollectionView.galleryCollectionView.reloadData()
                hideLoadingView()
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
