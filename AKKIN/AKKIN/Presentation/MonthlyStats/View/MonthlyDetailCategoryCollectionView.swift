//
//  MonthlyDetailCategoryCollectionView.swift
//  AKKIN
//
//  Created by SJW on 2023/10/11.
//

import UIKit

final class MonthlyDetailCategoryCollectionView: BaseView, UICollectionViewDelegate {
    
    var selectedButtonIndex: Int? = 0

    // MARK: UI Components
    public lazy var detailCategoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .akkinGray0
        collectionView.register(MonthlyDetailCategoryListCell.self, forCellWithReuseIdentifier: MonthlyDetailCategoryListCell.identifier)

        return collectionView
    }()

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .absolute(342),
                heightDimension: .absolute(75)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/7)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
            
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    // MARK: Properties
    var tapAdd: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        detailCategoryCollectionView.dataSource = self
        detailCategoryCollectionView.delegate = self

        addSubview(detailCategoryCollectionView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        detailCategoryCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}
extension MonthlyDetailCategoryCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            16
    }
}


extension MonthlyDetailCategoryCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = detailCategoryCollectionView
            .dequeueReusableCell(
            withReuseIdentifier:
                MonthlyDetailCategoryListCell.identifier,
            for: indexPath)
                as? MonthlyDetailCategoryListCell else { return UICollectionViewCell() }
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

    @objc func checkButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        if selectedButtonIndex != indexPath.item {
            selectedButtonIndex = indexPath.item
        }

        detailCategoryCollectionView.reloadData()
    }
}
