//
//  MonthlyTopStatsView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/20.
//

import UIKit

final class MonthlyTopStatsView: BaseView {
    
    private let ranking = ["5일", "9일", "14일"]

    // MARK: UI Components
    private let monthlyRangkingLabel = UILabel().then {
        $0.text = "랭킹 TOP3"
        $0.font = .systemFont(
            ofSize: 20,
            weight: .semibold
        )
    }

    private let monthlyStatsView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.13
        $0.layer.shadowOffset = .zero
    }

    private let monthlyTopRankingStatsTableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(
            MonthlyTopStatsTableViewCell.self,
            forCellReuseIdentifier:
                MonthlyTopStatsTableViewCell.identifier
        )
    }

    // MARK: Properties
    var tapAdd: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        monthlyTopRankingStatsTableView.dataSource = self
        monthlyTopRankingStatsTableView.delegate = self

        addSubview(monthlyRangkingLabel)
        addSubview(monthlyStatsView)
        
        monthlyStatsView.addSubview(monthlyTopRankingStatsTableView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        monthlyRangkingLabel.snp.makeConstraints {
            $0.top
                .equalToSuperview()
            $0.leading
                .equalToSuperview()
                .inset(24)
        }

        monthlyStatsView.snp.makeConstraints {
            $0.top
                .equalTo(monthlyRangkingLabel.snp.bottom)
                .offset(8)
            $0.leading
                .trailing.equalToSuperview()
                .inset(24)
            $0.height
                .equalTo(127)
        }

        monthlyTopRankingStatsTableView.snp.makeConstraints {
            $0.top
                .equalTo(monthlyStatsView.snp.top)
                .inset(8)
            $0.leading.trailing
                .equalToSuperview()
            $0.height
                .equalTo(111)
        }
    }
    
    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}

extension MonthlyTopStatsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        ranking.count
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 37
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = monthlyTopRankingStatsTableView.dequeueReusableCell(withIdentifier: MonthlyTopStatsTableViewCell.identifier, for: indexPath) as? MonthlyTopStatsTableViewCell else { return UITableViewCell() }
        
        cell.prepareForReuse()
        cell.selectionStyle = .none
        cell.rankingLabel.text = ranking[indexPath.row]
        cell.detailButton.addAction(UIAction(handler: { [weak self] _ in guard let self = self else { return }
            self.handleAddEvent()
        }), for: .touchUpInside)
        if indexPath.row == 0 {
            cell.moneyLabel.text = "12,000 원"
        } else if indexPath.row == 1 {
            cell.moneyLabel.text = "30,000 원"
        } else {
            cell.moneyLabel.text = "43,000 원"
        }

        return cell
    }
}
