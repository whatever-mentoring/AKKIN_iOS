//
//  MainMonthlyStatsView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/14.
//

import UIKit

final class MainMonthlyStatsView: BaseView {
    
    var monthlyCost = ["0", "0", "0", "0"]
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
        $0.text = "M월은 교통에서 가장 많이 아꼈어요."
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

        let range = (text as NSString).range(of: "교통")
        attributedText.addAttribute(.foregroundColor, value: UIColor.akkinGreen, range: range)
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
        getMain()

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
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(24)
        }

        monthlyStatsView.snp.makeConstraints {
            $0.top.equalTo(monthlyStatsLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(185)
        }

        monthLabel.snp.makeConstraints {
            $0.top.leading.equalTo(monthlyStatsView).inset(16)
        }

        detailButton.snp.makeConstraints {
            $0.centerY.equalTo(monthLabel.snp.centerY)
            $0.trailing.equalTo(monthlyStatsView).inset(15)
        }

        monthlyStatsTableView.snp.makeConstraints {
            $0.top.equalTo(monthLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(125)
        }
    }
    
    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}

extension MainMonthlyStatsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = monthlyStatsTableView.dequeueReusableCell(withIdentifier: MainMonthlyStatsTableViewCell.identifier, for: indexPath) as? MainMonthlyStatsTableViewCell else { return UITableViewCell() }
        
        cell.prepareForReuse()
        cell.selectionStyle = .none
        cell.categoryLabel.text = category[indexPath.row]
        cell.moneyLabel.text = "\(monthlyCost[indexPath.row])원"
        
        return cell
    }
}

extension MainMonthlyStatsView {
    // MARK: Networking
    private func getMain() {
        NetworkService.shared.main.getMain() { result in
            switch result {
            case .success(let response):
                guard let data = response as? MainResponse else { return }
                self.monthLabel.text = "\(data.month)월은 교통에서 가장 많이 아꼈어요."
                self.setLabelColor()
                self.monthlyCost[0] = data.monthlyDining.toPriceFormat
                self.monthlyCost[1] = data.monthlyTraffic.toPriceFormat
                self.monthlyCost[2] = data.monthlyShopping.toPriceFormat
                self.monthlyCost[3] = data.monthlyEtc.toPriceFormat
                self.monthlyStatsTableView.reloadData()
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
