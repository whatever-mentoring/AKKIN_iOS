//
//  MainCardCollectionView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/13.
//

import UIKit

final class MainCardCollectionView: BaseView {
    
    // MARK: UI Components
    public lazy var cardCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
        collectionView.isScrollEnabled = false
        collectionView.register(MainCardCollectionViewCell.self, forCellWithReuseIdentifier: MainCardCollectionViewCell.identifier)
        return collectionView
    }()

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(223)))
        item.contentInsets = .init(top: 0, leading: 7, bottom: 0, trailing: 7)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(223)), subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = .init(top: 16, leading: 24, bottom: 16, trailing: 24)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    // MARK: Properties
    var tapAdd: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        cardCollectionView.dataSource = self

        addSubview(cardCollectionView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        cardCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(255)
        }
    }
    
    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}

extension MainCardCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: MainCardCollectionViewCell.identifier, for: indexPath) as? MainCardCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
