//
//  WeeklyStatsCollectionView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/16.
//
import UIKit

final class WeeklyStatsCollectionView: BaseView, UICollectionViewDelegate {

    private let dayString = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    private let dayInt = ["3", "4", "5", "6", "7", "8", "9"]
    private let category = ["전체", "식비", "교통", "쇼핑", "취미", "기타"]
    var selectedButtonIndex = 0
    var selectedButton: UIButton?
 
    // MARK: UI Components
    public lazy var weekCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1)
        collectionView.register(WeeklyStatsCategoryCell.self, forCellWithReuseIdentifier: WeeklyStatsCategoryCell.identifier)
        collectionView.register(WeeklyStatsListCell.self, forCellWithReuseIdentifier: WeeklyStatsListCell.identifier)

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
        weekCollectionView.dataSource = self

        addSubview(weekCollectionView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        weekCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}

extension WeeklyStatsCollectionView: UICollectionViewDataSource {
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
        case 0:
            guard let cell = weekCollectionView.dequeueReusableCell(withReuseIdentifier: WeeklyStatsCategoryCell.identifier, for: indexPath) as? WeeklyStatsCategoryCell else { return UICollectionViewCell() }

            if indexPath.row == self.selectedButtonIndex {
                cell.categoryButton.isSelected = true
                cell.selectedCategory()
            }

            cell.categoryButton.setTitle(category[indexPath.row], for: .normal)
            cell.categoryButton.addTarget(self, action: #selector(checkButtonTapped(_:)), for: .touchUpInside)

            return cell
        default:
            guard let cell = weekCollectionView.dequeueReusableCell(withReuseIdentifier: WeeklyStatsListCell.identifier, for: indexPath) as? WeeklyStatsListCell else { return UICollectionViewCell() }

            return cell
        }
    }

    @objc func checkButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? WeeklyStatsCategoryCell,
              let indexPath = weekCollectionView.indexPath(for: cell) else {
            return
        }

        if indexPath.row != self.selectedButtonIndex {
            if cell.categoryButton.isSelected == false {
                cell.categoryButton.isSelected.toggle()
                cell.selectedCategory()
            }

            self.selectedButtonIndex = indexPath.row
        }
    }
    
}
