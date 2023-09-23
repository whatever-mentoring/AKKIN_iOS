//
//  MonthlyTopStatsView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/20.
//

import UIKit

final class MonthlyTopStatsView: BaseView {
    
    private let ranking = ["NN일", "NN일", "NN일"]

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
        $0.layer.shadowColor = UIColor.akkinGray1.cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowOffset = CGSize.zero
        $0.layer.shadowRadius = 12
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
        cell.moneyLabel.text = "000,000 원"
        
        return cell
    }
}
