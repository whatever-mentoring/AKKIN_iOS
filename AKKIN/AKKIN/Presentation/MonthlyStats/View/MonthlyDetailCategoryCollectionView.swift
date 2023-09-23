//
//  MonthlyDetailCategoryCollectionView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/24.
//

import UIKit

final class MonthlyDetailCategoryCollectionView: BaseView, UICollectionViewDelegate {
    private var dataSource: MonthlyDetailCategoryCollectionViewDataSource?
    
    var selectedButtonIndex = 0
    var selectedButton: UIButton?
 
    // MARK: UI Components
    public lazy var monthlyDetailCategoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
        collectionView.register(MonthlyDetailCategoryListCell.self, forCellWithReuseIdentifier: MonthlyDetailCategoryListCell.identifier)

        return collectionView
    }()

    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1/6),
                        heightDimension: .absolute(33)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 8)

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(33)), subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 5, leading: 5, bottom: 18, trailing: 5)

                return section

            default:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(93)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 13, trailing: 0)

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1/6)), subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)

                return section
            }
        }
    }

    // MARK: Properties
    var tapAdd: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        monthlyDetailCategoryCollectionView.dataSource = self

        addSubview(monthlyDetailCategoryCollectionView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        monthlyDetailCategoryCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
    func setCategory(_ category: String) {
        dataSource?.setCategoryItems(forCategory: category)
        monthlyDetailCategoryCollectionView.reloadData()
    }
}

extension MonthlyDetailCategoryCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 6
        case 1:
            return 10
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        default:
            guard let cell = monthlyDetailCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: MonthlyDetailCategoryListCell.identifier, for: indexPath) as? MonthlyDetailCategoryListCell else { return UICollectionViewCell() }
            
            return cell
        }
    }
}

