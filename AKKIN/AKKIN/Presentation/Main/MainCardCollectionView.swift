//
//  MainCardCollectionView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/13.
//

import UIKit

final class MainCardCollectionView: BaseView {
    
    // MARK: UI Components
    private let akkinLabel = UILabel().then {
        $0.text = "오늘 얼마 아낀거지?"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private let addButton = BaseButton().then {
        $0.setImage(UIImage(named: "addButton"), for: .normal)
    }

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
                widthDimension: .absolute(222),
                heightDimension: .absolute(262)))
        item.contentInsets = .init(top: 0, leading: 7, bottom: 0, trailing: 7)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.57),
                heightDimension: .absolute(262)), subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = .init(top: 16, leading: 24, bottom: 16, trailing: 24)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    // MARK: Properties
    var tapAdd: (() -> Void)?
    var tapCell: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        addButton.addTarget(self, action: #selector(handleAddEvent), for: .touchUpInside)
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self

        addSubview(akkinLabel)
        addSubview(addButton)
        addSubview(cardCollectionView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        akkinLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.equalToSuperview().inset(24)
        }

        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.centerY.equalTo(akkinLabel.snp.centerY)
        }

        cardCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(295)
        }
    }
    
    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }

    func handleCellEvent() {
        tapCell?()
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

extension MainCardCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleCellEvent()
    }
}
