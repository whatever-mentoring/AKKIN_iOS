//
//  MonthlyDetailCategoryListCell.swift
//  AKKIN
//
//  Created by SJW on 2023/10/15.
//

import UIKit

final class MonthlyDetailCategoryListCell: UICollectionViewCell {

    static let identifier = "MonthlyDetailCategoryListCell"
    
    private(set) var textStackView = UIStackView()

    private(set) var moneyLabel = UILabel().then {
        $0.text = "000,000원"
        $0.textColor = .akkinGreen
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    private(set) var dateLabel = UILabel().then {
        $0.text = "00일"
        $0.textColor = .akkinGray4
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }

    private(set) var contentLabel = UILabel().then {
        $0.text = "소비내용이 들어갑니다"
        $0.textColor = .akkinBlack
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
        contentView.backgroundColor = .akkinWhite
        contentView.layer.cornerRadius = 16
    }

    private func configureSubviews() {
        contentView.addSubview(textStackView)
        textStackView.addArrangedSubview(moneyLabel)
        textStackView.addArrangedSubview(dateLabel)
        contentView.addSubview(contentLabel)
    }

    private func makeConstraints() {
        textStackView.snp.makeConstraints {
            $0.top
                .equalToSuperview()
                .offset(12)
            $0.width
                .equalTo(310)
            $0.height
                .equalTo(26)
            $0.leading
                .equalToSuperview()
                .offset(16)
        }

        contentLabel.snp.makeConstraints {
            $0.top
                .equalTo(textStackView.snp.bottom)
                .offset(4)
            $0.leading
                .equalToSuperview()
                .offset(16)
            $0.bottom
                .equalToSuperview()
                .inset(12)
        }
    }
}
