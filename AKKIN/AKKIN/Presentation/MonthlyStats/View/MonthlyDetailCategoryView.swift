//
//  MonthlyDetailCategoryView.swift
//  AKKIN
//
//  Created by SJW on 2023/09/20.
//

import UIKit

final class MonthlyDetailCategoryView: BaseView {
    
    private let category = ["식비", "쇼핑", "교통", "기타"]

    // MARK: UI Components
    private let monthlyStatsLabel = UILabel().then {
        $0.text = "상세 카테고리"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
    }

    private let monthlyStatsView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor(red: 0.082, green: 0.082, blue: 0.082, alpha: 0.07).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowOffset = CGSize.zero
        $0.layer.shadowRadius = 12
    }

    private let monthlyStatsTableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(MonthlyDetailCategoryTableViewCell.self, forCellReuseIdentifier: MonthlyDetailCategoryTableViewCell.identifier)
    }

    // MARK: Properties
    var tapAdd: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        monthlyStatsTableView.dataSource = self
        monthlyStatsTableView.delegate = self

        addSubview(monthlyStatsLabel)
        addSubview(monthlyStatsView)

        monthlyStatsView.addSubview(monthlyStatsTableView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        monthlyStatsLabel.snp.makeConstraints {
            $0.top
                .equalToSuperview()
            $0.leading
                .equalToSuperview()
                .inset(24)
        }

        monthlyStatsView.snp.makeConstraints {
            $0.top
                .equalTo(monthlyStatsLabel.snp.bottom)
                .offset(8)
            $0.leading.trailing
                .equalToSuperview()
                .inset(24)
            $0.height
                .equalTo(168)
        }

        monthlyStatsTableView.snp.makeConstraints {
            $0.top
                .equalTo(monthlyStatsView.snp.top)
                .offset(8)
            $0.leading.trailing
                .equalToSuperview()
            $0.height
                .equalTo(144)
            $0.bottom
                .equalTo(monthlyStatsView.snp.bottom)
                .offset(-8)
        }
    }
    
    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}

extension MonthlyDetailCategoryView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        category.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = monthlyStatsTableView.dequeueReusableCell(withIdentifier: MonthlyDetailCategoryTableViewCell.identifier, for: indexPath) as? MonthlyDetailCategoryTableViewCell else { return UITableViewCell() }
        
        cell.prepareForReuse()
        cell.selectionStyle = .none
        cell.categoryLabel.text = category[indexPath.row]
        cell.moneyLabel.text = "000,000 원"
        
        return cell
    }
}

