//
//  OnboardingViewController.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/20.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    
    // MARK: UI Components
    var imageArr = [AkkinImage.akkinOnboarding1, AkkinImage.akkinOnboarding2, AkkinImage.akkinOnboarding3]
    
    public lazy var onboardingCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        return collectionView
    }()
    
    // MARK: Environment
    private let router = ExampleRouter()
    
    // MARK: Event
    @objc private func handleAddEvent() {
        router.presentLoginViewController()
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        router.viewController = self
    }

    func setCollectionView() {
        onboardingCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        onboardingCollectionView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
        onboardingCollectionView.dataSource = self
        onboardingCollectionView.delegate = self
        onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        onboardingCollectionView.isPagingEnabled = true
        onboardingCollectionView.showsHorizontalScrollIndicator = false
    }

    // MARK: Configuration
    override func configureSubviews() {
        view.addSubview(onboardingCollectionView)
    }

    // MARK: Layout
    override func makeConstraints() {
        onboardingCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func createLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        return flowLayout
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.onboardingImageView.image = imageArr[indexPath.row]
        cell.startButton.addTarget(self, action: #selector(handleAddEvent), for: .touchUpInside)
        cell.skipButton.addTarget(self, action: #selector(handleAddEvent), for: .touchUpInside)

        if indexPath.row == 2 {
            cell.startButton.isHidden = false
            cell.skipButton.isHidden = true
        }
        
        return cell
    }
}
