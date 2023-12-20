//
//  MainMonthlyStatsTableViewCell.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/14.
//

import UIKit

final class MainMonthlyStatsTableViewCell: UITableViewCell {

    static let identifier = "MainMonthlyStatsTableViewCell"

    private(set) var categoryLabel = UILabel().then {
        $0.text = "식비"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    private(set) var moneyLabel = UILabel().then {
        $0.text = "000,000 원"
        $0.font = .systemFont(ofSize: 16)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        makeConstraints()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
        moneyLabel.text = nil
    }

    private func configureSubviews() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(moneyLabel)
    }

    private func makeConstraints() {
        categoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }

        moneyLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
