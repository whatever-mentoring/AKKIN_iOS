//
//  MonthlyDetailCategoryTableViewCell.swift
//  AKKIN
//
//  Created by SJW on 2023/09/20.
//

import UIKit

final class MonthlyDetailCategoryTableViewCell: UITableViewCell {

    static let identifier = "MonthlyDetailCategoryTableViewCell"

    private(set) var categoryLabel = UILabel().then {
        $0.text = "식비"
        $0.textColor = .akkinBlack
        $0.font = .systemFont(ofSize: 18)
    }

    private(set) var moneyLabel = UILabel().then {
        $0.text = "000,000 원"
        $0.textColor = .akkinBlack
        $0.font = .systemFont(ofSize: 18)
    }
    
    private(set) var detailButton = UIButton().then {
        $0.setImage(AkkinButton.detailButton, for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
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
        contentView.addSubview(detailButton)
    }

    private func makeConstraints() {
        categoryLabel.snp.makeConstraints {
            $0.leading
                .equalToSuperview()
                .inset(16)
            $0.centerY
                .equalToSuperview()
        }

        moneyLabel.snp.makeConstraints {
            $0.trailing
                .equalToSuperview()
                .inset(36)
            $0.centerY
                .equalToSuperview()
        }
        
        detailButton.snp.makeConstraints {
            $0.trailing
                .equalToSuperview()
                .inset(16)
            $0.centerY
                .equalToSuperview()
        }
    }
}

