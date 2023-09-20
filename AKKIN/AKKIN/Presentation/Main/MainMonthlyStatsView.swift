//
//  MainMonthlyStatsView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/14.
//

import UIKit

final class MainMonthlyStatsView: BaseView {
    
    private let category = ["식비", "쇼핑", "교통", "기타"]

    // MARK: UI Components
    private let monthlyStatsLabel = UILabel().then {
        $0.text = "월간 통계"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private let monthlyStatsView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.07
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 8
    }

    private let monthLabel = UILabel().then {
        $0.text = "M월은 식비에서 가장 많이 아꼈어요."
        $0.font = .systemFont(ofSize: 16)
    }

    private let monthlyStatsTableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(MainMonthlyStatsTableViewCell.self, forCellReuseIdentifier: MainMonthlyStatsTableViewCell.identifier)
    }

    private let detailButton = UIButton().then {
        $0.setImage(UIImage(named: "detailButton"), for: .normal)
    }

    private func setLabelColor() {
        guard let text = monthLabel.text else {
            return
        }

        let attributedText = NSMutableAttributedString(string: text)

        let range = (text as NSString).range(of: "식비")
        attributedText.addAttribute(.foregroundColor, value: UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1), range: range)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .semibold), range: range)

        monthLabel.attributedText = attributedText
    }

    // MARK: Properties
    var tapAdd: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        monthlyStatsTableView.dataSource = self
        monthlyStatsTableView.delegate = self
        setLabelColor()
        
        detailButton.addTarget(self, action: #selector(handleAddEvent), for: .touchUpInside)
        
        addSubview(monthlyStatsLabel)
        addSubview(monthlyStatsView)

        monthlyStatsView.addSubview(monthLabel)
        monthlyStatsView.addSubview(detailButton)
        monthlyStatsView.addSubview(monthlyStatsTableView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        monthlyStatsLabel.snp.makeConstraints {
            $0.top
                .equalToSuperview()
                .inset(10)
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
                .equalTo(183)
        }

        monthLabel.snp.makeConstraints {
            $0.top.leading
                .equalTo(monthlyStatsView)
                .inset(16)
        }

        detailButton.snp.makeConstraints {
            $0.centerY
                .equalTo(monthLabel.snp.centerY)
            $0.trailing
                .equalTo(monthlyStatsView)
                .inset(15)
        }

        monthlyStatsTableView.snp.makeConstraints {
            $0.top
                .equalTo(monthLabel.snp.bottom)
                .offset(16)
            $0.leading.trailing
                .equalToSuperview()
            $0.height
                .equalTo(128)
        }
    }
    
    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}

extension MainMonthlyStatsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        category.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = monthlyStatsTableView.dequeueReusableCell(withIdentifier: MainMonthlyStatsTableViewCell.identifier, for: indexPath) as? MainMonthlyStatsTableViewCell else { return UITableViewCell() }
        
        cell.prepareForReuse()
        cell.selectionStyle = .none
        cell.categoryLabel.text = category[indexPath.row]
        cell.moneyLabel.text = "000,000 원"
        
        return cell
    }
}
