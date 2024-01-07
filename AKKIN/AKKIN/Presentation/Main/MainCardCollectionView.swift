//
//  MainCardCollectionView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/13.
//

import UIKit

final class MainCardCollectionView: BaseView {

    var todayEntries: [Entries] = []
    var selectedTodayEntries: [Entries] = []

    // MARK: UI Components
    private let akkinLabel = UILabel().then {
        $0.text = AkkinString.todayAkkin
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private let addButton = BaseButton().then {
        $0.setImage(AkkinButton.addButton, for: .normal)
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
    var tapCell: (([Entries]) -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        getMain()

        addButton.addTarget(self, action: #selector(handleAddEvent), for: .touchUpInside)
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        cardCollectionView.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)

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

    func handleCellEvent(_ selectedEntries: [Entries]) {
        tapCell?(selectedEntries)
    }
}

extension MainCardCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if todayEntries.count == 0 {
            return 1
        } else {
            return todayEntries.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: MainCardCollectionViewCell.identifier, for: indexPath) as? MainCardCollectionViewCell else { return UICollectionViewCell() }
        if todayEntries.count == 0 {
            cell.cardImageView.isHidden = true
            cell.moneyLabel.isHidden = true
            cell.saveContentLabel.isHidden = true
            cell.howLabel.isHidden = true
            cell.emptyLabel.isHidden = false
            cell.contentView.layer.borderColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1).cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
            cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        } else {
            cell.cardImageView.isHidden = false
            cell.moneyLabel.isHidden = false
            cell.saveContentLabel.isHidden = false
            cell.howLabel.isHidden = false
            cell.emptyLabel.isHidden = true
            cell.contentView.backgroundColor = .white
            cell.contentView.layer.borderWidth = 0
            cell.contentView.layer.cornerRadius = 16
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowOpacity = 0.07
            cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.contentView.layer.shadowRadius = 8

            let entry = todayEntries[indexPath.row]
            cell.cardImageView.image = UIImage(named: entry.imageUrl ?? "icon_1")
            cell.saveContentLabel.text = "[ " + "\(entry.how)" + " ]"
            cell.howLabel.text = entry.saveContent
            cell.moneyLabel.text = "무려 " + "\(entry.expectCost - entry.realCost)" + " 원"
        }

        return cell
    }
}

extension MainCardCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if todayEntries.count != 0 {
            let entry = todayEntries[indexPath.row]
            selectedTodayEntries = todayEntries.filter { $0.id == entry.id }
            handleCellEvent(selectedTodayEntries)
        }
    }
}

extension MainCardCollectionView {
    // MARK: Networking
    private func getMain() {
        print("main card - getMain called")
        NetworkService.shared.main.getMain() { result in
            switch result {
            case .success(let response):
                guard let data = response as? MainResponse else { return }
                self.todayEntries = data.today.entries
                print(data)
                self.cardCollectionView.reloadData()
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
