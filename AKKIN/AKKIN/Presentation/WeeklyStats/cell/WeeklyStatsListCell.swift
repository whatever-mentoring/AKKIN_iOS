//
//  WeeklyStatsListCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/16.
//
import UIKit

final class WeeklyStatsListCell: UICollectionViewCell {

    static let identifier = "WeeklyStatsListCell"

    private(set) var moneyLabel = UILabel().then {
        $0.text = "000,000원"
        $0.textColor = UIColor(red: 0.14, green: 0.68, blue: 0.37, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }

    private(set) var contentLabel = UILabel().then {
        $0.text = "소비내용이 들어갑니다"
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentView()
        configureSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func setContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
    }

    private func configureSubviews() {
        contentView.addSubview(moneyLabel)
        contentView.addSubview(contentLabel)
    }

    private func makeConstraints() {
        moneyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        contentLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
