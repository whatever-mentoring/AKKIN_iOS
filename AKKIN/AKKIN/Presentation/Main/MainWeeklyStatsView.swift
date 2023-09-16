//
//  MainWeeklyStatsView.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/14.
//

import UIKit

final class MainWeeklyStatsView: BaseView {
    
    // MARK: UI Components
    private let weeklyStatsLabel = UILabel().then {
        $0.text = "주간 통계"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private let weeklyStatsView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.07
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 8
    }

    private let weekLabel = UILabel().then {
        $0.text = "M월 n째주"
        $0.font = .systemFont(ofSize: 16)
    }

    private let detailButton = BaseButton().then {
        $0.setImage(UIImage(named: "detailButton"), for: .normal)
    }

    private let saveLabel = UILabel().then {
        $0.text = "000,000,000원 아꼈어요."
        $0.textColor = UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1)
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private func setLabelColor() {
        guard let text = saveLabel.text else {
            return
        }

        let attributedText = NSMutableAttributedString(string: text)

        let range = (text as NSString).range(of: "원 아꼈어요.")
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .regular), range: range)

        saveLabel.attributedText = attributedText
    }

    // MARK: Properties
    var tapAdd: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        setLabelColor()

        detailButton.addTarget(self, action: #selector(handleAddEvent), for: .touchUpInside)

        addSubview(weeklyStatsLabel)
        addSubview(weeklyStatsView)

        weeklyStatsView.addSubview(weekLabel)
        weeklyStatsView.addSubview(detailButton)
        weeklyStatsView.addSubview(saveLabel)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        weeklyStatsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(24)
        }

        weeklyStatsView.snp.makeConstraints {
            $0.top.equalTo(weeklyStatsLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(91)
        }

        weekLabel.snp.makeConstraints {
            $0.top.leading.equalTo(weeklyStatsView).inset(16)
        }

        detailButton.snp.makeConstraints {
            $0.centerY.equalTo(weekLabel.snp.centerY)
            $0.trailing.equalTo(weeklyStatsView).inset(15)
        }

        saveLabel.snp.makeConstraints {
            $0.bottom.leading.equalTo(weeklyStatsView).inset(16)
        }
    }
    
    // MARK: Event
    @objc private func handleAddEvent() {
        tapAdd?()
    }
}
