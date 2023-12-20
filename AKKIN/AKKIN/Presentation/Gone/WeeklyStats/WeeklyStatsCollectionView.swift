//
//  WeeklyStatsCollectionView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/16.
//
import UIKit

final class WeeklyStatsCollectionView: BaseView, UICollectionViewDelegate {

    var weeklyEntries: [WeeklyEntries] = []
    private let category = ["전체", "식비", "교통", "쇼핑", "기타"]
    var selectedButtonIndex: Int? = 0

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
                        heightDimension: .fractionalHeight(1/7)), subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)

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
        weekCollectionView.delegate = self

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
            return 5
        case 1:
            return 4
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = weekCollectionView.dequeueReusableCell(withReuseIdentifier: WeeklyStatsCategoryCell.identifier, for: indexPath) as? WeeklyStatsCategoryCell else { return UICollectionViewCell() }

            cell.categoryButton.tag = indexPath.item
                cell.categoryButton.addTarget(self, action: #selector(checkButtonTapped(_:)), for: .touchUpInside)
                
                if indexPath.item == selectedButtonIndex {
                    cell.categoryButton.isSelected = true
                    cell.selectedCategory()
                } else {
                    cell.categoryButton.isSelected = false
                    cell.selectedCategory()
                }
                
            cell.categoryButton.addTarget(self, action: #selector(checkButtonTapped(_:)), for: .touchUpInside)
            cell.categoryButton.setTitle(category[indexPath.row], for: .normal)

            return cell
        default:
            guard let cell = weekCollectionView.dequeueReusableCell(withReuseIdentifier: WeeklyStatsListCell.identifier, for: indexPath) as? WeeklyStatsListCell else { return UICollectionViewCell() }
            if indexPath.row == 0 {
                cell.contentLabel.text = "헝그리 정신 실천"
                cell.moneyLabel.text = "9,000원"
            } else if indexPath.row == 1 {
                cell.contentLabel.text = "쓰지 않을 결심"
                cell.moneyLabel.text = "17,000원"
            } else if indexPath.row == 2 {
                cell.contentLabel.text = "쾌락 추구"
                cell.moneyLabel.text = "2,000원"
            } else {
                cell.contentLabel.text = "힐링 여행"
                cell.moneyLabel.text = "200,000원"
            }
            return cell
        }
    }

    @objc func checkButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        if selectedButtonIndex != indexPath.item {
            selectedButtonIndex = indexPath.item
        }

        weekCollectionView.reloadData()
    }
}

extension WeeklyStatsCollectionView {
    // MARK: Networking
    private func getWeekly() {
        print("getWeekly")
        NetworkService.shared.weekly.getWeekly() { result in
            switch result {
            case .success(let response):
                guard let data = response as? WeeklyResponse else { return }
                self.weeklyEntries = data.entries
                print(data)
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