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
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private let monthlyStatsView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.13
        $0.layer.shadowOffset = .zero
    }

    private let monthlyStatsTableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(MonthlyDetailCategoryTableViewCell.self, forCellReuseIdentifier: MonthlyDetailCategoryTableViewCell.identifier)
    }

    // MARK: Properties
    var tapAdd: (() -> Void)?
    
    // MARK: Environment
    private let router = ExampleRouter()
    
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
                .equalTo(164)
        }

        monthlyStatsTableView.snp.makeConstraints {
            $0.top
                .equalTo(monthlyStatsView.snp.top)
                .offset(8)
            $0.leading.trailing
                .equalToSuperview()
            $0.height
                .equalTo(148)
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
        return 37
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = monthlyStatsTableView.dequeueReusableCell(withIdentifier: MonthlyDetailCategoryTableViewCell.identifier, for: indexPath) as? MonthlyDetailCategoryTableViewCell else { return UITableViewCell() }
        
        cell.prepareForReuse()
        cell.selectionStyle = .none
        cell.categoryLabel.text = category[indexPath.row]
        cell.detailButton.addAction(UIAction(handler: { [weak self] _ in guard let self = self else { return }
            self.handleAddEvent()
        }), for: .touchUpInside)
        
        if indexPath.row == 0 {
            cell.moneyLabel.text = "24,000 원"
        } else if indexPath.row == 1 {
            cell.moneyLabel.text = "30,000 원"
        } else if indexPath.row == 2 {
            cell.moneyLabel.text = "70,000 원"
        } else {
            cell.moneyLabel.text = "50,000 원"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("test tap cell \(indexPath.row)")
    }
}

